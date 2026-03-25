struct SoundEffectConfig: Equatable {
    let enabled: Bool
    let volume: Double
    let moveSound: String
    let captureSound: String

    static let defaultConfig = SoundEffectConfig(enabled: true, volume: 0.7, moveSound: "move", captureSound: "capture")
    static let muted = SoundEffectConfig(enabled: false, volume: 0.0, moveSound: "move", captureSound: "capture")
}
