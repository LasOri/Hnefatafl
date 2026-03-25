enum PieceHeatmap {
    static func heatValue(row: Int, col: Int, position: Position) -> Int {
        var count = 0
        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                guard position.pieceAt(row: r, col: c) != nil else { continue }
                let distance = abs(r - row) + abs(c - col)
                if distance <= 2 { count += 1 }
            }
        }
        return count
    }

    static func maxHeat(position: Position) -> Int {
        var best = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let heat = heatValue(row: row, col: col, position: position)
                if heat > best { best = heat }
            }
        }
        return best
    }
}
