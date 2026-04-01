enum TerritoryAggregator {
    static func compute(position: Position, player: Player) -> Int {
        // Base territory balance (attacker-positive)
        let balance = TerritoryBalance.evaluate(position: position)

        // Territory analysis
        let tAnalyzer = TerritoryAnalyzer.attackerPercentage(position: position)
        let tMapAtk = TerritoryControlMap.territoryCount(position: position, player: .attacker)
        let tMapDef = TerritoryControlMap.territoryCount(position: position, player: .defender)

        // Center and positioning
        let center = CenterControlScore.score(position: position, player: player)
        let central = CentralizationScore.score(position: position, player: player)

        // Column and row control
        let cols = ColumnControl.controlledColumns(position: position, player: player)
        let rows = RowControl.controlledRows(position: position, player: player)
        let diag = DiagonalControl.diagonalThreats(position: position, player: player)

        // Ring control
        let innerRing = RingControl.innerRingScore(position: position)
        let outerRing = RingControl.outerRingScore(position: position)

        // Edge control
        let edgeCtrl = BoardEdgeControl.edgeControl(position: position, player: player)

        // Board dominance
        let dominance = BoardDominance.evaluate(position: position)
        let domDiff: Int
        switch player {
        case .attacker:
            domDiff = dominance.attackerScore - dominance.defenderScore
        case .defender:
            domDiff = dominance.defenderScore - dominance.attackerScore
        }

        // Square control
        let sqDom = SquareDominance.dominanceScore(position: position)
        let ownedSq = SquareOwnership.ownedSquareCount(position: position, player: player)
        let keySq = KeySquareEval.keySquareControl(position: position, player: player)

        // Board balance
        let boardBal = BoardBalance.evaluate(position: position)

        // Normalize balance (attacker-positive)
        let baseAdj: Int
        switch player {
        case .attacker:
            baseAdj = balance
        case .defender:
            baseAdj = -balance
        }

        // Territory map difference
        let tMapDiff: Int
        switch player {
        case .attacker:
            tMapDiff = tMapAtk - tMapDef
        case .defender:
            tMapDiff = tMapDef - tMapAtk
        }

        // Analyzer percentage (50 = equal)
        let analyzerAdj: Int
        switch player {
        case .attacker:
            analyzerAdj = tAnalyzer - 50
        case .defender:
            analyzerAdj = 50 - tAnalyzer
        }

        // Inner ring: positive means attackers control it
        let ringAdj: Int
        switch player {
        case .attacker:
            ringAdj = innerRing + outerRing / 2
        case .defender:
            ringAdj = -(innerRing + outerRing / 2)
        }

        // Square dominance is attacker-positive
        let sqDomAdj: Int
        switch player {
        case .attacker:
            sqDomAdj = sqDom
        case .defender:
            sqDomAdj = -sqDom
        }

        let subSignal = (tMapDiff / 3 + analyzerAdj / 3 + center / 2 + central / 2
                        + cols + rows + diag / 2 + ringAdj / 3
                        + edgeCtrl.totalControl / 3 + domDiff / 3
                        + sqDomAdj / 3 + ownedSq / 3 + keySq / 2
                        + boardBal.score / 5) / 10

        // === Additional territory modules ===
        let opponent: Player = player == .attacker ? .defender : .attacker
        let sectorMe = BoardSector.pieceCountBySector(position: position, player: player)
        let sectorOpp = BoardSector.pieceCountBySector(position: position, player: opponent)
        let sectorSpread = sectorMe.count - sectorOpp.count

        let hSym = BoardSymmetryEval.horizontalSymmetry(position: position)
        let vSym = BoardSymmetryEval.verticalSymmetry(position: position)
        let symPenalty = Int((hSym + vSym) * 2)

        let centerDist = CenterMassEval.distanceFromCenter(position: position, player: player)
        let centerDistOpp = CenterMassEval.distanceFromCenter(position: position, player: opponent)

        let dispersion = DispersionIndex.index(position: position, player: player)
        let dispersionOpp = DispersionIndex.index(position: position, player: opponent)

        let extraTerritory = (sectorSpread + Int(centerDistOpp - centerDist) + Int(dispersionOpp - dispersion) - symPenalty / 3) / 4

        return baseAdj + subSignal / 3 + extraTerritory / 4
    }
}
