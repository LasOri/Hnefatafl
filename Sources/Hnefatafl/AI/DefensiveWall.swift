struct WallEntry: Equatable {
    let cornerRow: Int
    let cornerCol: Int
    let blockingCount: Int
}

enum DefensiveWall {
    static func detect(position: Position) -> [WallEntry] {
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var walls: [WallEntry] = []

        for corner in corners {
            let adjacentSquares: [(Int, Int)]
            switch corner {
            case (0, 0): adjacentSquares = [(0, 1), (1, 0)]
            case (0, 10): adjacentSquares = [(0, 9), (1, 10)]
            case (10, 0): adjacentSquares = [(10, 1), (9, 0)]
            case (10, 10): adjacentSquares = [(10, 9), (9, 10)]
            default: adjacentSquares = []
            }

            var blockers = 0
            for sq in adjacentSquares {
                if position.pieceAt(row: sq.0, col: sq.1) == .attacker {
                    blockers += 1
                }
            }

            if blockers > 0 {
                walls.append(WallEntry(cornerRow: corner.0, cornerCol: corner.1, blockingCount: blockers))
            }
        }

        return walls
    }
}
