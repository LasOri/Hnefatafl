struct LineOfSight {
    static func isClear(from: (Int, Int), to: (Int, Int), position: Position) -> Bool {
        if from.0 == to.0 && from.1 == to.1 { return true }
        guard from.0 == to.0 || from.1 == to.1 else { return false }

        let squares = squaresBetween(from: from, to: to)
        let size = Position.boardSize
        for sq in squares {
            if position.cells[sq.0 * size + sq.1] != nil {
                return false
            }
        }
        return true
    }

    static func squaresBetween(from: (Int, Int), to: (Int, Int)) -> [(Int, Int)] {
        var result: [(Int, Int)] = []

        if from.0 == to.0 {
            let minC = min(from.1, to.1)
            let maxC = max(from.1, to.1)
            for c in (minC + 1)..<maxC {
                result.append((from.0, c))
            }
        } else if from.1 == to.1 {
            let minR = min(from.0, to.0)
            let maxR = max(from.0, to.0)
            for r in (minR + 1)..<maxR {
                result.append((r, from.1))
            }
        }

        return result
    }
}
