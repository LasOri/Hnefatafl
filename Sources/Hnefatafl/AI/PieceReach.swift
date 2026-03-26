struct PieceReachEntry: Equatable {
    let row: Int
    let col: Int
    let reach: Int
}

enum PieceReach {
    static func compute(position: Position, row: Int, col: Int) -> Int {
        guard position.pieceAt(row: row, col: col) != nil else { return 0 }

        var count = 0
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for dir in directions {
            var r = row + dir.0
            var c = col + dir.1
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if position.pieceAt(row: r, col: c) != nil { break }
                count += 1
                r += dir.0
                c += dir.1
            }
        }
        return count
    }

    static func computeAll(position: Position) -> [PieceReachEntry] {
        var results: [PieceReachEntry] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) != nil {
                    let reach = compute(position: position, row: row, col: col)
                    results.append(PieceReachEntry(row: row, col: col, reach: reach))
                }
            }
        }
        return results
    }
}
