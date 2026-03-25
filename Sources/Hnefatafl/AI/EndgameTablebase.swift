struct TablebaseEntry: Equatable {
    let evaluation: Int
    let bestMoveDescription: String
}

enum EndgameTablebase {
    static func lookup(attackerCount: Int, defenderCount: Int) -> TablebaseEntry? {
        if defenderCount == 1 && attackerCount == 0 {
            return TablebaseEntry(evaluation: 10000, bestMoveDescription: "King escapes freely")
        }
        if defenderCount == 1 && attackerCount >= 4 {
            return TablebaseEntry(evaluation: -5000, bestMoveDescription: "King likely surrounded")
        }
        if attackerCount <= 2 && defenderCount >= 3 {
            return TablebaseEntry(evaluation: 8000, bestMoveDescription: "Defender material advantage")
        }
        return nil
    }

    static func isKnownEndgame(position: Position) -> Bool {
        let total = position.attackerCount + position.defenderCount
        return total <= 6
    }
}
