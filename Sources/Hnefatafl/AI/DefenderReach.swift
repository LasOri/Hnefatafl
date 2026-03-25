enum DefenderReach {
    static func reachableInOne(position: Position) -> Int {
        var reachable = Set<Int>()
        let moves = position.allLegalMoves(for: .defender)
        for move in moves {
            reachable.insert(move.toRow * Position.boardSize + move.toCol)
        }
        return reachable.count
    }

    static func totalReach(position: Position) -> Int {
        var squares = Set<Int>()
        let moves = position.allLegalMoves(for: .defender)
        for move in moves {
            squares.insert(move.toRow * Position.boardSize + move.toCol)
        }
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .defender || piece == .king {
                    squares.insert(row * Position.boardSize + col)
                }
            }
        }
        return squares.count
    }
}
