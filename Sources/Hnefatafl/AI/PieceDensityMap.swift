enum PieceDensityMap {
    static func density(position: Position, centerRow: Int, centerCol: Int, radius: Int) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) != nil {
                    let distance = abs(row - centerRow) + abs(col - centerCol)
                    if distance <= radius {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    static func highDensityZones(position: Position, threshold: Int) -> [(row: Int, col: Int)] {
        var zones: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let d = density(position: position, centerRow: row, centerCol: col, radius: 2)
                if d >= threshold {
                    zones.append((row, col))
                }
            }
        }
        return zones
    }
}
