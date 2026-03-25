enum AttackerFormation {
    static func ringPressure(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else {
            return 0
        }

        var pressure = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let distance = abs(row - kingPos.row) + abs(col - kingPos.col)
                    if distance <= 3 {
                        pressure += (4 - distance) * 10
                    }
                }
            }
        }

        return pressure
    }

    static func cornerBlockScore(position: Position) -> Int {
        let corners = [(0, 0), (0, Position.boardSize - 1), (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        var score = 0

        for corner in corners {
            if hasAttackerNearCorner(corner: corner, position: position) {
                score += 20
            }
        }

        return score
    }

    static func total(position: Position) -> Int {
        return ringPressure(position: position) + cornerBlockScore(position: position)
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func hasAttackerNearCorner(corner: (Int, Int), position: Position) -> Bool {
        let adjacentPositions = [
            (corner.0 + 1, corner.1),
            (corner.0 - 1, corner.1),
            (corner.0, corner.1 + 1),
            (corner.0, corner.1 - 1)
        ]

        for pos in adjacentPositions {
            if pos.0 >= 0 && pos.0 < Position.boardSize && pos.1 >= 0 && pos.1 < Position.boardSize {
                if position.pieceAt(row: pos.0, col: pos.1) == .attacker {
                    return true
                }
            }
        }

        return false
    }
}
