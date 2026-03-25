import Testing
@testable import Hnefatafl

@Suite("Theme Preference Tests")
struct ThemePreferenceTests {

    @Test("next after light is dark")
    func nextAfterLight() {
        #expect(ThemePreference.next(after: .light) == .dark)
    }

    @Test("next after dark is system")
    func nextAfterDark() {
        #expect(ThemePreference.next(after: .dark) == .system)
    }

    @Test("next after system wraps to light")
    func nextAfterSystem() {
        #expect(ThemePreference.next(after: .system) == .light)
    }

    @Test("css class is lowercase with prefix")
    func cssClass() {
        #expect(ThemePreference.cssClass(for: .light) == "theme-light")
        #expect(ThemePreference.cssClass(for: .dark) == "theme-dark")
        #expect(ThemePreference.cssClass(for: .system) == "theme-system")
    }

    @Test("ThemeChoice label matches raw value")
    func labelMatchesRaw() {
        for choice in ThemeChoice.allCases {
            #expect(choice.label == choice.rawValue)
        }
    }
}
