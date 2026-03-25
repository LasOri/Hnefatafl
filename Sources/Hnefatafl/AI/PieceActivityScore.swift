struct PieceActivityScore {
    static func compute(position: Position, player: Player) -> Int {
        position.allLegalMoves(for: player).count
    }

    static func averageActivity(position: Position, player: Player) -> Double {
        let moves = position.allLegalMoves(for: player).count
        let pieces = player == .attacker ? position.attackerCount : position.defenderCount
        guard pieces > 0 else { return 0 }
        return Double(moves) / Double(pieces)
    }

    static func kingActivity(position: Position) -> Int {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return position.legalMoves(forPieceAtRow: row, col: col).count
                }
            }
        }
        return 0
    }
}
