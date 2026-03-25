enum NumericalAdvantage {
    static func localAdvantage(position: Position, row: Int, col: Int, radius: Int) -> Int {
        var attackers = 0
        var defenders = 0
        let minRow = max(0, row - radius)
        let maxRow = min(Position.boardSize - 1, row + radius)
        let minCol = max(0, col - radius)
        let maxCol = min(Position.boardSize - 1, col + radius)
        for r in minRow...maxRow {
            for c in minCol...maxCol {
                switch position.pieceAt(row: r, col: c) {
                case .attacker: attackers += 1
                case .defender, .king: defenders += 1
                case nil: break
                }
            }
        }
        return attackers - defenders
    }

    static func globalAdvantage(position: Position) -> Int {
        position.attackerCount - position.defenderCount
    }
}
