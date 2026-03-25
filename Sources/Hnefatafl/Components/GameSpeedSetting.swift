struct GameSpeedSetting: Equatable {
    let animationDuration: Double
    let autoPlayDelay: Double

    static let slow = GameSpeedSetting(animationDuration: 0.8, autoPlayDelay: 3.0)
    static let normal = GameSpeedSetting(animationDuration: 0.4, autoPlayDelay: 1.5)
    static let fast = GameSpeedSetting(animationDuration: 0.15, autoPlayDelay: 0.5)
}
