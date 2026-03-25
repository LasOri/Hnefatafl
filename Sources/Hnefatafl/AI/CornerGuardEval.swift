enum CornerGuardEval {
    private static let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]

    static func guardedCornerCount(position: Position) -> Int {
        corners.filter { corner in
            hasAdjacentAttacker(row: corner.0, col: corner.1, position: position)
        }.count
    }

    static func cornerGuardStrength(position: Position) -> Int {
        corners.reduce(0) { total, corner in
            total + adjacentAttackerCount(row: corner.0, col: corner.1, position: position)
        }
    }

    private static func hasAdjacentAttacker(row: Int, col: Int, position: Position) -> Bool {
        adjacentAttackerCount(row: row, col: col, position: position) > 0
    }

    private static func adjacentAttackerCount(row: Int, col: Int, position: Position) -> Int {
        let deltas = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        return deltas.reduce(0) { count, delta in
            let r = row + delta.0
            let c = col + delta.1
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { return count }
            return position.pieceAt(row: r, col: c) == .attacker ? count + 1 : count
        }
    }
}
