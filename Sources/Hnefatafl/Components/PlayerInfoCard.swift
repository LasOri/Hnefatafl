struct PlayerInfoCard: Equatable {
    let player: Player
    let pieceCount: Int
    let capturesMade: Int
    let isCurrentTurn: Bool

    var displayTitle: String {
        switch player {
        case .attacker: return "Attacker"
        case .defender: return "Defender"
        }
    }

    var captureText: String {
        capturesMade == 1 ? "1 capture" : "\(capturesMade) captures"
    }
}
