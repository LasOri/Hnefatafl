struct AnimationSettings: Equatable {
    var moveSpeed: Double
    var captureDelay: Double
    var highlightDuration: Double

    static let standard = AnimationSettings(moveSpeed: 0.3, captureDelay: 0.15, highlightDuration: 0.5)
    static let fast = AnimationSettings(moveSpeed: 0.15, captureDelay: 0.08, highlightDuration: 0.25)
    static let none = AnimationSettings(moveSpeed: 0, captureDelay: 0, highlightDuration: 0)
}
