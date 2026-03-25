enum AdaptiveEval {
    static func evaluate(position: Position, player: Player) -> Int {
        let phase = EndgameDetector.phase(position: position)
        switch phase {
        case .opening: return openingEval(position: position, player: player)
        case .midgame: return midgameEval(position: position, player: player)
        case .endgame: return endgameEval(position: position, player: player)
        }
    }

    private static func openingEval(position: Position, player: Player) -> Int {
        let mobility = position.allLegalMoves(for: player).count
        return mobility * 5
    }

    private static func midgameEval(position: Position, player: Player) -> Int {
        let material: Int
        switch player {
        case .attacker: material = position.attackerCount - position.defenderCount
        case .defender: material = position.defenderCount - position.attackerCount
        }
        return material * 50
    }

    private static func endgameEval(position: Position, player: Player) -> Int {
        let material: Int
        switch player {
        case .attacker: material = position.attackerCount - position.defenderCount
        case .defender: material = position.defenderCount - position.attackerCount
        }
        return material * 100
    }
}
