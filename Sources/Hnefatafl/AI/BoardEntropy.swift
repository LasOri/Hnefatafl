enum BoardEntropy {
    static func compute(position: Position) -> Int {
        var pieceCount = 0
        var rowSpread = Set<Int>()
        var colSpread = Set<Int>()

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) != nil {
                    pieceCount += 1
                    rowSpread.insert(row)
                    colSpread.insert(col)
                }
            }
        }

        guard pieceCount > 0 else { return 0 }

        return pieceCount * rowSpread.count * colSpread.count / 11
    }
}
