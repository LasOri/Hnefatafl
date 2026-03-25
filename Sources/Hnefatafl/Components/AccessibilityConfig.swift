struct AccessibilityConfig: Equatable {
    let highContrast: Bool
    let largeText: Bool
    let screenReaderMode: Bool
    let reduceMotion: Bool

    var needsSimplifiedUI: Bool {
        screenReaderMode || reduceMotion
    }

    static let standard = AccessibilityConfig(
        highContrast: false,
        largeText: false,
        screenReaderMode: false,
        reduceMotion: false
    )

    static let enhanced = AccessibilityConfig(
        highContrast: true,
        largeText: true,
        screenReaderMode: true,
        reduceMotion: true
    )
}
