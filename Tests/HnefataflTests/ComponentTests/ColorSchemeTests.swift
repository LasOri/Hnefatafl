import Testing
@testable import Hnefatafl

@Suite("ColorScheme Tests")
struct ColorSchemeTests {

    @Test("classic preset has correct name")
    func classicName() {
        #expect(ColorScheme.classic.name == "Classic")
    }

    @Test("modern preset has correct name")
    func modernName() {
        #expect(ColorScheme.modern.name == "Modern")
    }

    @Test("high contrast preset has correct name")
    func highContrastName() {
        #expect(ColorScheme.highContrast.name == "High Contrast")
    }

    @Test("all presets have hex colors")
    func hexColors() {
        let schemes = [ColorScheme.classic, .modern, .highContrast]
        for scheme in schemes {
            #expect(scheme.boardLight.hasPrefix("#"))
            #expect(scheme.boardDark.hasPrefix("#"))
            #expect(scheme.highlightColor.hasPrefix("#"))
        }
    }

    @Test("presets are distinct")
    func presetsDistinct() {
        #expect(ColorScheme.classic != ColorScheme.modern)
        #expect(ColorScheme.modern != ColorScheme.highContrast)
        #expect(ColorScheme.classic != ColorScheme.highContrast)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = ColorScheme(boardLight: "#fff", boardDark: "#000", highlightColor: "#f00", name: "Test")
        let b = ColorScheme(boardLight: "#fff", boardDark: "#000", highlightColor: "#f00", name: "Test")
        #expect(a == b)
    }
}
