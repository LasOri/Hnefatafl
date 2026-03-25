enum BoardSymmetryEval {
    static func horizontalSymmetry(position: Position) -> Double {
        let size = Position.boardSize
        let midRow = size / 2
        var matchCount = 0
        var totalCount = 0

        for row in 0..<midRow {
            let mirrorRow = size - 1 - row
            for col in 0..<size {
                totalCount += 1
                let top = position.pieceAt(row: row, col: col)
                let bottom = position.pieceAt(row: mirrorRow, col: col)
                if top == bottom { matchCount += 1 }
            }
        }

        guard totalCount > 0 else { return 1.0 }
        return Double(matchCount) / Double(totalCount)
    }

    static func verticalSymmetry(position: Position) -> Double {
        let size = Position.boardSize
        let midCol = size / 2
        var matchCount = 0
        var totalCount = 0

        for row in 0..<size {
            for col in 0..<midCol {
                totalCount += 1
                let left = position.pieceAt(row: row, col: col)
                let right = position.pieceAt(row: row, col: size - 1 - col)
                if left == right { matchCount += 1 }
            }
        }

        guard totalCount > 0 else { return 1.0 }
        return Double(matchCount) / Double(totalCount)
    }
}
