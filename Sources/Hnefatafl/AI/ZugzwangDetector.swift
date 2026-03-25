enum ZugzwangDetector {
    static func isZugzwang(position: Position, player: Player) -> Bool {
        zugzwangScore(position: position, player: player) < 0
    }

    static func zugzwangScore(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        guard !moves.isEmpty else { return 0 }
        let baseEval = evaluate(position: position, player: player)
        var worstDelta = 0
        var allWorse = true
        for move in moves {
            let after = position.applyMove(move)
            let afterEval = evaluate(position: after, player: player)
            let delta = afterEval - baseEval
            if delta >= 0 { allWorse = false; break }
            worstDelta = min(worstDelta, delta)
        }
        guard allWorse else { return 0 }
        return worstDelta
    }

    private static func evaluate(position: Position, player: Player) -> Int {
        switch player {
        case .attacker:
            return position.attackerCount * 10 - position.defenderCount * 10
        case .defender:
            var score = position.defenderCount * 10 - position.attackerCount * 10
            if let king = findKing(position: position) {
                score += position.legalMoves(forPieceAtRow: king.row, col: king.col).count * 3
            }
            return score
        }
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
