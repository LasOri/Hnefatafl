import Testing
@testable import Hnefatafl

@Suite("Keyboard Shortcut Tests")
struct KeyboardShortcutTests {

    @Test("shortcut registry has entries")
    func hasEntries() {
        let shortcuts = KeyboardShortcuts.all
        #expect(shortcuts.count >= 5)
    }

    @Test("arrow keys are registered")
    func arrowKeys() {
        let shortcuts = KeyboardShortcuts.all
        let hasArrow = shortcuts.contains { $0.key == "ArrowUp" }
        #expect(hasArrow)
    }

    @Test("escape is registered")
    func escapeKey() {
        let shortcuts = KeyboardShortcuts.all
        let hasEscape = shortcuts.contains { $0.key == "Escape" }
        #expect(hasEscape)
    }

    @Test("shortcuts have descriptions")
    func descriptions() {
        for shortcut in KeyboardShortcuts.all {
            #expect(!shortcut.description.isEmpty)
        }
    }

    @Test("shortcuts have categories")
    func categories() {
        for shortcut in KeyboardShortcuts.all {
            #expect(!shortcut.category.isEmpty)
        }
    }

    @Test("KeyboardShortcut is Equatable")
    func equatable() {
        let a = KeyboardShortcut(key: "a", description: "test", category: "nav")
        let b = KeyboardShortcut(key: "a", description: "test", category: "nav")
        #expect(a == b)
    }

    @Test("navigation category exists")
    func navigationCategory() {
        let nav = KeyboardShortcuts.all.filter { $0.category == "Navigation" }
        #expect(nav.count >= 4)
    }

    @Test("enter key is registered")
    func enterKey() {
        let shortcuts = KeyboardShortcuts.all
        let hasEnter = shortcuts.contains { $0.key == "Enter" }
        #expect(hasEnter)
    }
}
