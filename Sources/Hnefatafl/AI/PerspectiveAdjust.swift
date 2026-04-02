enum PerspectiveAdjust {
    /// Returns value for attacker, -value for defender (for attacker-positive signals)
    static func forAttackerPositive(_ value: Int, player: Player) -> Int {
        switch player {
        case .attacker: return value
        case .defender: return -value
        }
    }

    /// Returns value for defender, -value for attacker (for defender-positive signals)
    static func forDefenderPositive(_ value: Int, player: Player) -> Int {
        switch player {
        case .attacker: return -value
        case .defender: return value
        }
    }
}
