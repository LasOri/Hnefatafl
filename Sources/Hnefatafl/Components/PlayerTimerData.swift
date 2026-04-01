import LINKER

struct PlayerTimerData: Equatable {
    let player: Player
    let remainingSeconds: Double
    let isRunning: Bool

    var formattedTime: String {
        let totalSeconds = Int(remainingSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(minutes):\(zeroPad(seconds, width: 2))"
    }

    var isLow: Bool {
        remainingSeconds < 60.0
    }
}
