enum CrossfireDetector {
    static func crossfireSquares(position: Position) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard position.pieceAt(row: row, col: col) == nil else { continue }
                if attackersThatCanReach(position: position, row: row, col: col) >= 2 {
                    result.append((row, col))
                }
            }
        }
        return result
    }

    static func crossfireCount(position: Position) -> Int {
        crossfireSquares(position: position).count
    }

    private static func attackersThatCanReach(position: Position, row: Int, col: Int) -> Int {
        var count = 0
        for dc in [-1, 1] {
            var c = col + dc
            while c >= 0 && c < Position.boardSize {
                if let piece = position.pieceAt(row: row, col: c) {
                    if piece == .attacker { count += 1 }
                    break
                }
                c += dc
            }
        }
        for dr in [-1, 1] {
            var r = row + dr
            while r >= 0 && r < Position.boardSize {
                if let piece = position.pieceAt(row: r, col: col) {
                    if piece == .attacker { count += 1 }
                    break
                }
                r += dr
            }
        }
        return count
    }
}
