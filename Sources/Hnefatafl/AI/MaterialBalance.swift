enum MaterialBalance {
    static func balance(position: Position) -> Int {
        position.attackerCount - position.defenderCount
    }

    static func normalizedBalance(position: Position) -> Double {
        let total = position.attackerCount + position.defenderCount
        guard total > 0 else { return 0 }
        return Double(position.attackerCount - position.defenderCount) / Double(total)
    }

    static func isBalanced(position: Position, threshold: Int = 3) -> Bool {
        abs(balance(position: position)) <= threshold
    }

    static func advantage(position: Position) -> Player? {
        let bal = balance(position: position)
        if bal > 3 { return .attacker }
        if bal < -3 { return .defender }
        return nil
    }
}
