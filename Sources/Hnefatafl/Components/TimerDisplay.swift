struct TimerDisplayData: Equatable {
    let minutes: Int
    let seconds: Int
    let formatted: String
    let isLow: Bool
}

enum TimerDisplay {
    static func format(totalSeconds: Int, lowThreshold: Int = 30) -> TimerDisplayData {
        let mins = totalSeconds / 60
        let secs = totalSeconds % 60
        let formatted = String(format: "%d:%02d", mins, secs)
        return TimerDisplayData(minutes: mins, seconds: secs, formatted: formatted, isLow: totalSeconds <= lowThreshold)
    }
}
