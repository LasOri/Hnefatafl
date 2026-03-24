import Testing
@testable import Hnefatafl

@Suite("Hotkey Binding Tests")
struct HotkeyBindingTests {

    @Test("default bindings include N for new game")
    func newGameBinding() {
        let bindings = HotkeyBindings.defaults
        let action = bindings.action(for: "n")
        #expect(action != nil)
    }

    @Test("default bindings include U for undo")
    func undoBinding() {
        let bindings = HotkeyBindings.defaults
        let action = bindings.action(for: "u")
        #expect(action != nil)
    }

    @Test("unknown key returns nil")
    func unknownKey() {
        let bindings = HotkeyBindings.defaults
        let action = bindings.action(for: "z")
        #expect(action == nil)
    }

    @Test("custom binding overrides default")
    func customOverride() {
        var bindings = HotkeyBindings.defaults
        bindings = bindings.bind(key: "x", to: "new-game")
        let action = bindings.action(for: "x")
        #expect(action == "new-game")
    }

    @Test("unbind removes mapping")
    func unbind() {
        var bindings = HotkeyBindings.defaults
        bindings = bindings.unbind(key: "n")
        let action = bindings.action(for: "n")
        #expect(action == nil)
    }

    @Test("HotkeyBindings is Equatable")
    func equatable() {
        let a = HotkeyBindings.defaults
        let b = HotkeyBindings.defaults
        #expect(a == b)
    }

    @Test("all default bindings are non-empty strings")
    func allNonEmpty() {
        let bindings = HotkeyBindings.defaults
        for (key, action) in bindings.mappings {
            #expect(!key.isEmpty)
            #expect(!action.isEmpty)
        }
    }

    @Test("M key toggles mute")
    func muteBinding() {
        let bindings = HotkeyBindings.defaults
        let action = bindings.action(for: "m")
        #expect(action == "toggle-mute")
    }
}
