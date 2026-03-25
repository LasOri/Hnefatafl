import Testing
@testable import Hnefatafl

@Suite("AccessibilityConfig Tests")
struct AccessibilityConfigTests {

    @Test("standard preset has all features disabled")
    func standardAllDisabled() {
        let config = AccessibilityConfig.standard
        #expect(config.highContrast == false)
        #expect(config.largeText == false)
        #expect(config.screenReaderMode == false)
        #expect(config.reduceMotion == false)
    }

    @Test("enhanced preset has all features enabled")
    func enhancedAllEnabled() {
        let config = AccessibilityConfig.enhanced
        #expect(config.highContrast == true)
        #expect(config.largeText == true)
        #expect(config.screenReaderMode == true)
        #expect(config.reduceMotion == true)
    }

    @Test("needsSimplifiedUI true when screenReaderMode is on")
    func simplifiedUIForScreenReader() {
        let config = AccessibilityConfig(highContrast: false, largeText: false, screenReaderMode: true, reduceMotion: false)
        #expect(config.needsSimplifiedUI == true)
    }

    @Test("needsSimplifiedUI true when reduceMotion is on")
    func simplifiedUIForReduceMotion() {
        let config = AccessibilityConfig(highContrast: false, largeText: false, screenReaderMode: false, reduceMotion: true)
        #expect(config.needsSimplifiedUI == true)
    }

    @Test("needsSimplifiedUI false when both off")
    func noSimplifiedUI() {
        let config = AccessibilityConfig(highContrast: true, largeText: true, screenReaderMode: false, reduceMotion: false)
        #expect(config.needsSimplifiedUI == false)
    }

    @Test("AccessibilityConfig conforms to Equatable")
    func equatableConformance() {
        #expect(AccessibilityConfig.standard == AccessibilityConfig.standard)
        #expect(AccessibilityConfig.standard != AccessibilityConfig.enhanced)
    }

    @Test("enhanced preset needsSimplifiedUI")
    func enhancedNeedsSimplifiedUI() {
        #expect(AccessibilityConfig.enhanced.needsSimplifiedUI == true)
    }
}
