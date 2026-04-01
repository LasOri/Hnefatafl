enum MoveOrderingPipeline {
    static let pvBonus = 10000
    static let killerBonus = 5000
    static let captureBonus = 1000

    static func order(
        moves: [Move],
        position: Position,
        player: Player,
        killers: KillerMoveTable,
        history: HistoryTable,
        depth: Int,
        pvMove: Move?
    ) -> [Move] {
        guard !moves.isEmpty else { return [] }

        let killerMoves = killers.killers(at: depth)
        let threatMap = ThreatMap.compute(position: position, for: player)

        return moves.sorted { a, b in
            let scoreA = scoreMove(a, position: position, player: player, killerMoves: killerMoves, history: history, pvMove: pvMove, threatMap: threatMap)
            let scoreB = scoreMove(b, position: position, player: player, killerMoves: killerMoves, history: history, pvMove: pvMove, threatMap: threatMap)
            return scoreA > scoreB
        }
    }

    private static func scoreMove(
        _ move: Move,
        position: Position,
        player: Player,
        killerMoves: [Move],
        history: HistoryTable,
        pvMove: Move?,
        threatMap: [Int]
    ) -> Int {
        var score = 0

        // PV bonus (highest priority)
        if let pvMove, move == pvMove {
            score += pvBonus
        }

        // Killer bonus
        if killerMoves.contains(move) {
            score += killerBonus
        }

        // SEE-based capture scoring (replaces naive capture check)
        let newPosition = position.applyMove(move)
        let oldPieces = position.attackerCount + position.defenderCount
        let newPieces = newPosition.attackerCount + newPosition.defenderCount
        if newPieces < oldPieces {
            let see = SEEvaluator.evaluate(position: position, targetRow: move.toRow, targetCol: move.toCol)
            score += captureBonus + see
        }

        // Move category bonus
        let category = MoveCategory.categorize(move: move, position: position, player: player)
        switch category {
        case .capture: score += 500
        case .escape: score += 400
        case .defensive: score += 200
        case .quiet: break
        }

        // Move urgency
        let urgency = MoveUrgency.score(move: move, position: position, player: player)
        score += urgency / 3

        // Threat map: bonus for moving to threatened squares (aggressive)
        let boardSize = Position.boardSize
        let destIndex = move.toRow * boardSize + move.toCol
        if destIndex < threatMap.count {
            score += threatMap[destIndex] * 2
        }

        // Move impact
        let impact = MoveImpact.assess(move: move, position: position, player: player)
        score += impact.totalImpact / 10

        // Move efficiency (tiebreaker)
        let eff = MoveEfficiency.efficiency(move: move)
        score += Int(eff * 5)

        // Heuristic score from MoveSorter
        let heuristic = MoveSorter.heuristicScore(move: move, position: position, player: player)
        score += heuristic / 5

        // History table score
        score += history.score(for: move)

        return score
    }
}
