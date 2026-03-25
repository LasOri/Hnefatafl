enum AttackerMobility {
    static func totalMobility(position: Position) -> Int {
        position.allLegalMoves(for: .attacker).count
    }

    static func averageMobility(position: Position) -> Double {
        let total = totalMobility(position: position)
        let attackerCount = position.attackerCount
        guard attackerCount > 0 else { return 0 }
        return Double(total) / Double(attackerCount)
    }
}
