enum SupportNetwork {
    static func supportPairs(position: Position, player: Player) -> Int {
        let pieces = collectPieces(position: position, player: player)
        var pairs = 0

        for i in 0..<pieces.count {
            for j in (i + 1)..<pieces.count {
                let distance = abs(pieces[i].row - pieces[j].row) + abs(pieces[i].col - pieces[j].col)
                if distance == 1 {
                    pairs += 1
                }
            }
        }

        return pairs
    }

    static func unsupported(position: Position, player: Player) -> Int {
        let pieces = collectPieces(position: position, player: player)
        var count = 0

        for piece in pieces {
            let hasAlly = pieces.contains { other in
                guard other.row != piece.row || other.col != piece.col else { return false }
                let distance = abs(other.row - piece.row) + abs(other.col - piece.col)
                return distance == 1
            }

            if !hasAlly {
                count += 1
            }
        }

        return count
    }

    private static func collectPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        var result: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), targetPieces.contains(piece) {
                    result.append((row, col))
                }
            }
        }

        return result
    }
}
