struct GamePhaseInfo: Equatable {
    let phase: GamePhase
    let label: String
    let description: String
}

enum GamePhaseLabel {
    static func info(for position: Position) -> GamePhaseInfo {
        let phase = EndgameDetector.phase(position: position)
        switch phase {
        case .opening:
            return GamePhaseInfo(phase: .opening, label: "Opening", description: "Establish position and control")
        case .midgame:
            return GamePhaseInfo(phase: .midgame, label: "Midgame", description: "Tactical battles and captures")
        case .endgame:
            return GamePhaseInfo(phase: .endgame, label: "Endgame", description: "King escape or final capture")
        }
    }
}
