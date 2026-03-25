struct KingFreedom: Equatable {
    let mobility: Int
    let clearPaths: Int
    let adjacentDefenders: Int
    let score: Int
}

enum KingFreedomIndex {
    static func compute(position: Position) -> KingFreedom {
        guard let kingPos = findKing(position: position) else {
            return KingFreedom(mobility: 0, clearPaths: 0, adjacentDefenders: 0, score: 0)
        }

        let mobility = position.legalMoves(forPieceAtRow: kingPos.row, col: kingPos.col).count
        let clearPaths = countClearPaths(kingRow: kingPos.row, kingCol: kingPos.col, position: position)
        let adjacentDefenders = countAdjacentDefenders(kingRow: kingPos.row, kingCol: kingPos.col, position: position)

        let score = mobility * 10 + clearPaths * 20 + adjacentDefenders * 15

        return KingFreedom(
            mobility: mobility,
            clearPaths: clearPaths,
            adjacentDefenders: adjacentDefenders,
            score: score
        )
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func countClearPaths(kingRow: Int, kingCol: Int, position: Position) -> Int {
        let corners = [(0, 0), (0, Position.boardSize - 1), (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        var clearCount = 0

        for corner in corners {
            if hasClearPath(from: (kingRow, kingCol), to: corner, position: position) {
                clearCount += 1
            }
        }

        return clearCount
    }

    private static func hasClearPath(from: (Int, Int), to: (Int, Int), position: Position) -> Bool {
        let dRow = to.0 > from.0 ? 1 : (to.0 < from.0 ? -1 : 0)
        let dCol = to.1 > from.1 ? 1 : (to.1 < from.1 ? -1 : 0)

        var r = from.0 + dRow
        var c = from.1 + dCol

        while r != to.0 || c != to.1 {
            if r < 0 || r >= Position.boardSize || c < 0 || c >= Position.boardSize {
                return false
            }
            if position.pieceAt(row: r, col: c) != nil {
                return false
            }
            r += dRow
            c += dCol
        }

        return true
    }

    private static func countAdjacentDefenders(kingRow: Int, kingCol: Int, position: Position) -> Int {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var count = 0

        for (dRow, dCol) in directions {
            let r = kingRow + dRow
            let c = kingCol + dCol

            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                continue
            }

            if position.pieceAt(row: r, col: c) == .defender {
                count += 1
            }
        }

        return count
    }
}
