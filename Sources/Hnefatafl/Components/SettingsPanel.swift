struct GameSettings: Equatable {
    var soundEnabled: Bool = true
    var animationsEnabled: Bool = true
    var showCoordinates: Bool = true
    var showLegalMoves: Bool = true
    var confirmMoves: Bool = false

    mutating func toggle(_ setting: SettingKey) {
        switch setting {
        case .sound: soundEnabled.toggle()
        case .animations: animationsEnabled.toggle()
        case .coordinates: showCoordinates.toggle()
        case .legalMoves: showLegalMoves.toggle()
        case .confirmMoves: confirmMoves.toggle()
        }
    }
}

enum SettingKey: String, CaseIterable, Equatable {
    case sound, animations, coordinates, legalMoves, confirmMoves
    var label: String {
        switch self {
        case .sound: return "Sound"
        case .animations: return "Animations"
        case .coordinates: return "Coordinates"
        case .legalMoves: return "Legal Moves"
        case .confirmMoves: return "Confirm Moves"
        }
    }
}
