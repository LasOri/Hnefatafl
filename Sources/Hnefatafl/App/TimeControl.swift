struct TimeControl: Equatable {
    let initialSeconds: Int
    let increment: IncrementConfig

    var isUntimed: Bool { initialSeconds == 0 }

    var label: String {
        if isUntimed { return "No time limit" }
        let minutes = initialSeconds / 60
        if increment.secondsPerMove > 0 {
            return "\(minutes)min + \(increment.secondsPerMove)s"
        }
        return "\(minutes) min"
    }

    static let blitz = TimeControl(initialSeconds: 300, increment: .none)
    static let rapid = TimeControl(initialSeconds: 900, increment: .fischer)
    static let classical = TimeControl(initialSeconds: 1800, increment: .bronstein)
    static let untimed = TimeControl(initialSeconds: 0, increment: .none)
}
