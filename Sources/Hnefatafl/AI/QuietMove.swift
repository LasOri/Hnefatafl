enum QuietMove {
    static func isQuiet(move: Move, position: Position, player: Player) -> Bool {
        let newPos = position.applyMove(move)

        let enemyBefore: Int
        let enemyAfter: Int
        if player == .attacker {
            enemyBefore = countPieces(position, matching: { $0 == .defender || $0 == .king })
            enemyAfter = countPieces(newPos, matching: { $0 == .defender || $0 == .king })
        } else {
            enemyBefore = countPieces(position, matching: { $0 == .attacker })
            enemyAfter = countPieces(newPos, matching: { $0 == .attacker })
        }
        if enemyAfter < enemyBefore { return false }

        if player == .defender && position.pieceAt(row: move.fromRow, col: move.fromCol) == .king {
            let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
            if corners.contains(where: { $0.0 == move.toRow && $0.1 == move.toCol }) {
                return false
            }
        }

        return true
    }

    private static func countPieces(_ position: Position, matching predicate: (Piece) -> Bool) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), predicate(piece) {
                    count += 1
                }
            }
        }
        return count
    }
}
