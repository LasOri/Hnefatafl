struct SoundSettings: Equatable {
    let volume: Double
    let enabled: Bool

    init(volume: Double = 0.8, enabled: Bool = true) {
        self.volume = min(max(volume, 0), 1.0)
        self.enabled = enabled
    }

    func mute() -> SoundSettings {
        SoundSettings(volume: volume, enabled: false)
    }

    func unmute() -> SoundSettings {
        SoundSettings(volume: volume, enabled: true)
    }

    func withVolume(_ newVolume: Double) -> SoundSettings {
        SoundSettings(volume: newVolume, enabled: enabled)
    }

    var effectiveVolume: Double {
        enabled ? volume : 0
    }
}
