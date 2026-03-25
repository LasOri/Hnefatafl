enum DynamicEval {
    static func evaluate(position: Position, player: Player, moveCount: Int) -> Int {
        let base = materialScore(position: position, player: player)
        let phase = moveCount < 10 ? 0.3 : (moveCount < 30 ? 0.6 : 1.0)
        let mobility = position.allLegalMoves(for: player).count
        return base + Int(Double(mobility) * phase * 5)
    }

    private static func materialScore(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return (position.attackerCount - position.defenderCount) * 100
        case .defender: return (position.defenderCount - position.attackerCount) * 100
        }
    }
}
