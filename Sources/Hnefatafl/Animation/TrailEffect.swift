struct TrailEffect {
    static func intermediateSquares(for move: Move) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []

        if move.fromRow == move.toRow {
            let step = move.toCol > move.fromCol ? 1 : -1
            var col = move.fromCol + step
            while col != move.toCol {
                result.append((row: move.fromRow, col: col))
                col += step
            }
        } else if move.fromCol == move.toCol {
            let step = move.toRow > move.fromRow ? 1 : -1
            var row = move.fromRow + step
            while row != move.toRow {
                result.append((row: row, col: move.fromCol))
                row += step
            }
        }

        return result
    }

    static func opacities(count: Int) -> [Double] {
        guard count > 0 else { return [] }
        return (0..<count).map { i in
            0.4 * (1.0 - Double(i) / Double(count))
        }
    }
}
