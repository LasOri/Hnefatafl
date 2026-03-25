struct MoveTimestamp: Equatable {
    let moveIndex: Int
    let elapsedSeconds: Double

    var formattedTime: String {
        let totalSeconds = Int(elapsedSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
