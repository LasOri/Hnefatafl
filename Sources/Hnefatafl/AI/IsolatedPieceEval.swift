enum IsolatedPieceEval {
    static func isolatedCount(position: Position, player: Player) -> Int {
        var count = 0
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col),
                      targetPieces.contains(piece) else { continue }

                if !hasFriendlyNeighbor(row: row, col: col, player: player, position: position) {
                    count += 1
                }
            }
        }

        return count
    }

    static func isolationPenalty(position: Position, player: Player) -> Int {
        let count = isolatedCount(position: position, player: player)
        return -count * 15
    }

    private static func hasFriendlyNeighbor(row: Int, col: Int, player: Player, position: Position) -> Bool {
        let friendlyPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        let neighbors = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]

        for (r, c) in neighbors {
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c), friendlyPieces.contains(piece) {
                return true
            }
        }

        return false
    }
}
