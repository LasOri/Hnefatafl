enum PieceInfluenceRadius {
    static func influence(row: Int, col: Int, position: Position) -> Int {
        guard let piece = position.pieceAt(row: row, col: col) else {
            return 0
        }

        var count = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for (dRow, dCol) in directions {
            var r = row + dRow
            var c = col + dCol

            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if position.pieceAt(row: r, col: c) != nil {
                    break
                }
                count += 1
                r += dRow
                c += dCol
            }
        }

        return count
    }

    static func totalInfluence(position: Position, player: Player) -> Int {
        var total = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col) {
                    let piecePlayer: Player
                    switch piece {
                    case .attacker:
                        piecePlayer = .attacker
                    case .defender, .king:
                        piecePlayer = .defender
                    }

                    if piecePlayer == player {
                        total += influence(row: row, col: col, position: position)
                    }
                }
            }
        }

        return total
    }
}
