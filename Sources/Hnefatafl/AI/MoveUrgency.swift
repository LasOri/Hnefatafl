enum MoveUrgency {
    static func score(move: Move, position: Position, player: Player) -> Int {
        var urgency = 0

        let newPos = position.applyMove(move)

        if player == .defender && position.pieceAt(row: move.fromRow, col: move.fromCol) == .king {
            let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
            if corners.contains(where: { $0.0 == move.toRow && $0.1 == move.toCol }) {
                urgency += 100
            }
        }

        let enemyBefore: Int
        let enemyAfter: Int
        if player == .attacker {
            enemyBefore = countPieces(position: position, matching: { $0 == .defender || $0 == .king })
            enemyAfter = countPieces(position: newPos, matching: { $0 == .defender || $0 == .king })
        } else {
            enemyBefore = countPieces(position: position, matching: { $0 == .attacker })
            enemyAfter = countPieces(position: newPos, matching: { $0 == .attacker })
        }
        let captured = enemyBefore - enemyAfter
        if captured > 0 {
            urgency += captured * 30
        }

        let centerDist = abs(move.toRow - 5) + abs(move.toCol - 5)
        if centerDist <= 2 {
            urgency += 5
        }

        return urgency
    }

    private static func countPieces(position: Position, matching predicate: (Piece) -> Bool) -> Int {
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
