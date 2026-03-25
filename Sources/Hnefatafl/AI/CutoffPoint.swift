enum CutoffPoint {
    static func criticalPoints(position: Position) -> [(row: Int, col: Int)] {
        var points: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if isCutoffSquare(row: row, col: col, position: position) {
                    points.append((row, col))
                }
            }
        }

        return points
    }

    static func isCutoffSquare(row: Int, col: Int, position: Position) -> Bool {
        guard position.pieceAt(row: row, col: col) == nil else { return false }

        let hasHorizontalBlock = hasBlockOnAxis(row: row, col: col, horizontal: true, position: position)
        let hasVerticalBlock = hasBlockOnAxis(row: row, col: col, horizontal: false, position: position)

        return hasHorizontalBlock && hasVerticalBlock
    }

    private static func hasBlockOnAxis(row: Int, col: Int, horizontal: Bool, position: Position) -> Bool {
        var foundBefore = false
        var foundAfter = false

        if horizontal {
            for c in 0..<col {
                if position.pieceAt(row: row, col: c) != nil {
                    foundBefore = true
                    break
                }
            }
            for c in (col + 1)..<Position.boardSize {
                if position.pieceAt(row: row, col: c) != nil {
                    foundAfter = true
                    break
                }
            }
        } else {
            for r in 0..<row {
                if position.pieceAt(row: r, col: col) != nil {
                    foundBefore = true
                    break
                }
            }
            for r in (row + 1)..<Position.boardSize {
                if position.pieceAt(row: r, col: col) != nil {
                    foundAfter = true
                    break
                }
            }
        }

        return foundBefore && foundAfter
    }
}
