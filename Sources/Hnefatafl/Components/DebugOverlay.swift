struct DebugOverlay: Equatable {
    let isVisible: Bool

    init(isVisible: Bool = false) {
        self.isVisible = isVisible
    }

    func toggle() -> DebugOverlay {
        DebugOverlay(isVisible: !isVisible)
    }

    static func info(for state: GameState) -> [String: String] {
        let balance = PieceBalance.compute(position: state.game.position)
        return [
            "position": PositionSerializer.serialize(position: state.game.position),
            "moveCount": String(state.game.moveHistory.count),
            "currentPlayer": state.game.currentPlayer == .attacker ? "Attacker" : "Defender",
            "attackers": String(balance.attackers),
            "defenders": String(balance.defenders),
        ]
    }
}
