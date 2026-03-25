enum EscapeCornerCoverage {
    static func coveredCorners(position: Position) -> Int {
        let corners = [
            (0, 0),
            (0, Position.boardSize - 1),
            (Position.boardSize - 1, 0),
            (Position.boardSize - 1, Position.boardSize - 1)
        ]

        var covered = 0
        for corner in corners {
            if isCornerCovered(row: corner.0, col: corner.1, position: position) {
                covered += 1
            }
        }

        return covered
    }

    static func coverageScore(position: Position) -> Int {
        return coveredCorners(position: position) * 25
    }

    private static func isCornerCovered(row: Int, col: Int, position: Position) -> Bool {
        for r in max(0, row - 2)...min(Position.boardSize - 1, row + 2) {
            for c in max(0, col - 2)...min(Position.boardSize - 1, col + 2) {
                let distance = abs(r - row) + abs(c - col)
                if distance <= 2 && position.pieceAt(row: r, col: c) == .attacker {
                    return true
                }
            }
        }

        return false
    }
}
