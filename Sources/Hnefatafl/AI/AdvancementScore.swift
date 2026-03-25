enum AdvancementScore {
    static func attackerAdvancement(position: Position) -> Int {
        var total = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let distanceFromEdge = minEdgeDistance(row: row, col: col)
                    total += distanceFromEdge
                }
            }
        }

        return total
    }

    static func defenderAdvancement(position: Position) -> Int {
        let center = Position.boardSize / 2
        var total = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .defender || piece == .king {
                    let distanceFromCenter = abs(row - center) + abs(col - center)
                    total += distanceFromCenter
                }
            }
        }

        return total
    }

    private static func minEdgeDistance(row: Int, col: Int) -> Int {
        let top = row
        let bottom = Position.boardSize - 1 - row
        let left = col
        let right = Position.boardSize - 1 - col
        return min(top, bottom, left, right)
    }
}
