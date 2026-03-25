struct AnimationTiming: Equatable {
    let duration: Double
    let delay: Double
    let easing: String

    static let fast = AnimationTiming(duration: 0.15, delay: 0.0, easing: "ease-out")
    static let normal = AnimationTiming(duration: 0.3, delay: 0.0, easing: "ease-in-out")
    static let slow = AnimationTiming(duration: 0.6, delay: 0.1, easing: "ease-in-out")

    var totalDuration: Double {
        duration + delay
    }
}
