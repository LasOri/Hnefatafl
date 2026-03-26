enum MovePath {
    static func squares(for move: Move) -> [(Int, Int)] {
        if move.fromRow == move.toRow && move.fromCol == move.toCol {
            return [(move.fromRow, move.fromCol)]
        }

        var result: [(Int, Int)] = []

        if move.fromRow == move.toRow {
            let step = move.toCol > move.fromCol ? 1 : -1
            var col = move.fromCol
            while col != move.toCol + step {
                result.append((move.fromRow, col))
                col += step
            }
        } else {
            let step = move.toRow > move.fromRow ? 1 : -1
            var row = move.fromRow
            while row != move.toRow + step {
                result.append((row, move.fromCol))
                row += step
            }
        }

        return result
    }
}
