struct PlayerTimerData: Equatable {
    let player: Player
    let remainingSeconds: Double
    let isRunning: Bool

    var formattedTime: String {
        let totalSeconds = Int(remainingSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var isLow: Bool {
        remainingSeconds < 60.0
    }
}
