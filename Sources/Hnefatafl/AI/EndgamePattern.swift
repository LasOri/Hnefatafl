enum EndgamePatternDetector {
    static func detectPattern(position: Position) -> String? {
        let defCount = position.defenderCount
        let atkCount = position.attackerCount
        if defCount == 1 && atkCount <= 2 {
            return "Lone King"
        }
        if defCount == 2 && atkCount <= 3 {
            return "King + 1 Defender"
        }
        if atkCount <= 2 && defCount >= 3 {
            return "Attacker Collapse"
        }
        if atkCount >= 10 && defCount <= 3 {
            return "Overwhelming Force"
        }
        return nil
    }

    static func isKnownWin(position: Position, for player: Player) -> Bool {
        let defCount = position.defenderCount
        let atkCount = position.attackerCount
        if player == .defender {
            return atkCount <= 2 && defCount >= 3
        }
        return defCount == 1 && atkCount >= 4
    }
}
