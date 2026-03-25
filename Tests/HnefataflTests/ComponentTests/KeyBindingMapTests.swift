import Testing
@testable import Hnefatafl

@Suite("Key Binding Map Tests")
struct KeyBindingMapTests {

    @Test("has bindings")
    func hasBindings() {
        #expect(KeyBindingMap.bindings.isEmpty == false)
    }

    @Test("count is five")
    func countIsFive() {
        #expect(KeyBindingMap.count == 5)
    }

    @Test("z maps to undo")
    func zMapsToUndo() {
        #expect(KeyBindingMap.action(forKey: "z") == "undo")
    }

    @Test("escape maps to deselect")
    func escapeMapsToDeselect() {
        #expect(KeyBindingMap.action(forKey: "Escape") == "deselect")
    }

    @Test("unknown key returns nil")
    func unknownKeyNil() {
        #expect(KeyBindingMap.action(forKey: "q") == nil)
    }
}
