enum PositionAggregator {
    static func compute(position: Position, player: Player) -> Int {
        let opponent = player.opponent

        let base = baseScore(position: position, player: player)
        let formation = formationSignal(position: position, player: player, opponent: opponent)
        let extraPiece = extraPieceSignal(position: position, player: player, opponent: opponent)
        let extraForm = extraFormSignal(position: position, player: player)
        let importance = importanceBonus()

        return base + formation / 3 + extraPiece / 4 + extraForm / 5 + importance / 5
    }

    // MARK: - Base score: king proximity to corners

    private static func baseScore(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var kingRow: Int?
        var kingCol: Int?

        for row in 0..<size {
            for col in 0..<size {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                    break
                }
            }
            if kingRow != nil { break }
        }

        guard let kr = kingRow, let kc = kingCol else { return 0 }

        let corners = [(0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1)]
        let minDistance = corners.map { abs(kr - $0.0) + abs(kc - $0.1) }.min()!
        let proximityScore = 10 - minDistance

        // King proximity to corner favors defender
        return PerspectiveAdjust.forDefenderPositive(proximityScore, player: player)
    }

    // MARK: - Formation / coordination signal

    private static func formationSignal(position: Position, player: Player, opponent: Player) -> Int {
        // Piece square table
        let pst = PieceSquareTable.totalScore(position: position, player: player)
        let pstOpp = PieceSquareTable.totalScore(position: position, player: opponent)

        // Formation scores
        let atkForm = AttackerFormation.total(position: position)
        let defCoh = DefenderCohesion.total(position: position)
        let defSpace = DefenderSpacing.spacingScore(position: position)
        let atkConv = AttackerConvergence.convergenceScore(position: position)
        let atkSurf = AttackSurface.surfaceArea(position: position)

        // Piece coordination
        let coord = PieceCoordination.score(position: position, player: player)
        let coordOpp = PieceCoordination.score(position: position, player: opponent)
        let harmony = PieceHarmonyScore.harmony(position: position, player: player)
        let harmonyOpp = PieceHarmonyScore.harmony(position: position, player: opponent)

        // Connectivity
        let connected = PieceConnectivity.largestGroupSize(position: position, player: player)
        let connectedOpp = PieceConnectivity.largestGroupSize(position: position, player: opponent)

        // Distribution balance
        let distTop = PieceDistribution.topHalf(position: position, player: player)
        let distBot = PieceDistribution.bottomHalf(position: position, player: player)
        let distBalance = min(distTop, distBot)

        // Support network
        let support = SupportNetwork.supportPairs(position: position, player: player)
        let unsupported = SupportNetwork.unsupported(position: position, player: player)

        // Wall/barrier
        let wallStr = WallFormation.evaluate(position: position)
        let barrier = BarrierStrength.evaluate(position: position)
        let shield = PawnShieldEval.evaluate(position: position)

        // Anchor and chain
        let anchors = AnchorSquare.anchorCount(position: position, player: player)
        let chain = PawnChain.longestChain(position: position, player: player)

        // Isolation penalty
        let isolated = IsolatedPieceEval.isolationPenalty(position: position, player: player)
        let structIso = PawnStructureAnalyzer.isolatedCount(position: position, player: player)

        // Defender formation bonus
        let defForm = DefenderFormation.classify(position: position)
        let formBonus: Int
        switch defForm {
        case .diamond: formBonus = 5
        case .fortress: formBonus = 8
        case .scattered: formBonus = -3
        case .none: formBonus = 0
        }

        // Piece formation shape
        let shape = PieceFormationShape.classify(position: position, player: player)
        let shapeBonus: Int
        switch shape {
        case .line: shapeBonus = 2
        case .cluster: shapeBonus = 3
        case .arc: shapeBonus = 4
        case .scattered: shapeBonus = -2
        }

        // Combine sub-signals
        let pstDiff = (pst - pstOpp) / 5
        let coordDiff = (coord - coordOpp) / 2 + (harmony - harmonyOpp) / 2
        let connDiff = connected - connectedOpp

        // Attacker-specific
        let atkSignal = atkForm / 3 + atkConv / 3 + atkSurf / 5
        // Defender-specific
        let defSignal = defCoh / 3 + defSpace / 3 + formBonus

        let formAdj: Int
        switch player {
        case .attacker:
            formAdj = atkSignal - defSignal
        case .defender:
            formAdj = defSignal - atkSignal
        }

        // Structural factors (walls/barriers favor attacker siege)
        let structAdj: Int
        switch player {
        case .attacker:
            structAdj = wallStr / 3 + barrier / 3 - shield / 3
        case .defender:
            structAdj = shield / 3 - wallStr / 3 - barrier / 3
        }

        return (pstDiff + coordDiff / 2 + connDiff + distBalance / 3
                        + support / 2 - unsupported / 2 + anchors / 2 + chain / 2
                        - isolated / 2 - structIso + shapeBonus + formAdj + structAdj) / 8
    }

    // MARK: - Additional piece analysis

    private static func extraPieceSignal(position: Position, player: Player, opponent: Player) -> Int {
        let blockage = PieceBlockageEval.blockageScore(position: position, player: player)
        let exchange = PieceExchange.exchangeBalance(position: position, player: player)
        let influence = PieceInfluenceRadius.totalInfluence(position: position, player: player)
        let influenceOpp = PieceInfluenceRadius.totalInfluence(position: position, player: opponent)
        let momentum: Int
        switch player {
        case .attacker:
            momentum = PieceMomentum.attackerMomentum(position: position) - PieceMomentum.defenderMomentum(position: position)
        case .defender:
            momentum = PieceMomentum.defenderMomentum(position: position) - PieceMomentum.attackerMomentum(position: position)
        }
        let adjacency = AdjacentPieceCount.maxAdjacency(position: position, player: player)

        // Wire remaining piece modules
        let pieceClusterInfo = PieceCluster.analyze(position: position, player: player)
        let pieceClusterCount = pieceClusterInfo.count
        let groupCount = PieceGrouping.find(position: position, for: player).count
        let alignments = PieceAlignment.detect(position: position, for: player).count
        let reachEntries = PieceReach.computeAll(position: position)
        let reachTotal = reachEntries.count
        let proximity = PieceProximity.averageProximity(position: position, player: player)
        let defensiveWalls = DefensiveWall.detect(position: position).count

        return (-blockage / 3 + exchange / 3 + (influence - influenceOpp) / 5
                               + momentum / 3 + adjacency / 3 + pieceClusterCount / 3
                               + groupCount / 3 + alignments / 3 + reachTotal / 5
                               + Int(proximity) / 3 + defensiveWalls / 2) / 8
    }

    // MARK: - Attack formation + reserve

    private static func extraFormSignal(position: Position, player: Player) -> Int {
        let atkReserve = AttackerReserve.reserveStrength(position: position)
        let atkFormClass = AttackFormation.classify(position: position)
        let atkFormBonus: Int
        switch atkFormClass {
        case .wedge: atkFormBonus = 5
        case .line: atkFormBonus = 3
        case .scattered: atkFormBonus = -2
        case .none: atkFormBonus = 0
        }
        let throneCtrl = ThroneProximity.throneControlScore(position: position)
        let edgeDist = EdgeDistanceCalc.averageEdgeDistance(position: position, player: player)
        let attackerSpreadVar = AttackerSpread.variance(position: position)

        let result: Int
        switch player {
        case .attacker:
            result = atkFormBonus + atkReserve / 3 + throneCtrl / 3 - Int(edgeDist) - Int(attackerSpreadVar) / 5
        case .defender:
            result = -atkFormBonus - atkReserve / 3 - throneCtrl / 3 + Int(edgeDist) + Int(attackerSpreadVar) / 5
        }
        return result
    }

    // MARK: - Square importance

    private static func importanceBonus() -> Int {
        let importanceRanking = SquareImportance.ranking()
        return importanceRanking.isEmpty ? 0 : importanceRanking[0].importance / 5
    }
}
