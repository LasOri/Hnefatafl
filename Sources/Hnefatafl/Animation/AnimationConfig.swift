struct AnimationConfig: Equatable {
    let spring: SpringConfig
    let durationMs: Int

    static let forMove = AnimationConfig(
        spring: .gentle,
        durationMs: settlingTime(for: .gentle)
    )

    static let forCapture = AnimationConfig(
        spring: .stiff,
        durationMs: settlingTime(for: .stiff)
    )

    private static func settlingTime(for config: SpringConfig) -> Int {
        let spring = Spring(config: config)
        var time = 0.05
        while time < 2.0 {
            if spring.isSettled(at: time, from: 0.0, to: 1.0, threshold: 0.01) {
                return Int(time * 1000)
            }
            time += 0.05
        }
        return 500
    }
}
