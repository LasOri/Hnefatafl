struct MoveSorter {
    static func sort(moves: [Move], position: Position, player: Player) -> [Move] {
        moves.sorted { a, b in
            score(move: a, position: position, player: player) >
            score(move: b, position: position, player: player)
        }
    }

    static func score(move: Move, position: Position, player: Player) -> Int {
        var s = 0
        let size = Position.boardSize
        let center = size / 2

        let newPosition = position.applyMove(move)
        let capturedBefore = position.cells.compactMap({ $0 }).count
        let capturedAfter = newPosition.cells.compactMap({ $0 }).count
        if capturedAfter < capturedBefore {
            s += 100
        }

        let isCorner = (move.toRow == 0 || move.toRow == size - 1) &&
                       (move.toCol == 0 || move.toCol == size - 1)
        if isCorner {
            if position.pieceAt(row: move.fromRow, col: move.fromCol) == .king {
                s += 1000
            }
        }

        let distToCenter = abs(move.toRow - center) + abs(move.toCol - center)
        s += max(0, 10 - distToCenter)

        return s
    }
}
