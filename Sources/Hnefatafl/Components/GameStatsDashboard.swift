struct DashboardEntry: Equatable {
    let label: String
    let value: String
}

struct DashboardSection: Equatable {
    let title: String
    let entries: [DashboardEntry]
}

struct Dashboard: Equatable {
    let sections: [DashboardSection]
}

struct GameStatsDashboard {
    static func build(state: GameState) -> Dashboard {
        let balance = PieceBalance.compute(position: state.game.position)
        let turn = state.game.currentPlayer == .attacker ? "Attacker" : "Defender"

        let materialSection = DashboardSection(title: "Material", entries: [
            DashboardEntry(label: "Attackers", value: String(balance.attackers)),
            DashboardEntry(label: "Defenders", value: String(balance.defenders)),
            DashboardEntry(label: "Ratio", value: String(format: "%.1f", balance.ratio)),
        ])

        let turnSection = DashboardSection(title: "Turn", entries: [
            DashboardEntry(label: "Current", value: turn),
            DashboardEntry(label: "Move", value: String(state.game.moveHistory.count + 1)),
        ])

        return Dashboard(sections: [materialSection, turnSection])
    }
}
