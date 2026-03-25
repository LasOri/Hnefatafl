struct GameAlertConfig: Equatable {
    let message: String
    let severity: Int
    let isDismissed: Bool

    var isActive: Bool {
        severity > 0 && !isDismissed
    }

    static func lowTime() -> GameAlertConfig {
        GameAlertConfig(message: "Low time warning", severity: 2, isDismissed: false)
    }

    static func kingInDanger() -> GameAlertConfig {
        GameAlertConfig(message: "King is in danger", severity: 3, isDismissed: false)
    }
}
