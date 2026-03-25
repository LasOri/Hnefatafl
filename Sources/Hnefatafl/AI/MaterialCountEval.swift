enum MaterialCountEval {
    static func evaluate(position: Position, attackerValue: Int, defenderValue: Int, kingValue: Int) -> Int {
        let attackerScore = position.attackerCount * attackerValue
        let hasKing = kingExists(position: position)
        let defenderPureCount = hasKing ? position.defenderCount - 1 : position.defenderCount
        let defenderScore = defenderPureCount * defenderValue + (hasKing ? kingValue : 0)
        return defenderScore - attackerScore
    }

    static func standardEval(position: Position) -> Int {
        evaluate(position: position, attackerValue: 1, defenderValue: 1, kingValue: 3)
    }

    private static func kingExists(position: Position) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return true }
            }
        }
        return false
    }
}
