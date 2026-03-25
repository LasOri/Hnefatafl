import Testing
@testable import Hnefatafl

@Suite("PopoverConfig Tests")
struct PopoverConfigTests {

    @Test("hasOptions is true when options exist")
    func hasOptionsTrue() {
        let config = PopoverConfig(title: "Menu", options: ["Move", "Cancel"], isVisible: true, anchorRow: 3, anchorCol: 5)
        #expect(config.hasOptions)
    }

    @Test("hasOptions is false when options empty")
    func hasOptionsFalse() {
        let config = PopoverConfig(title: "Empty", options: [], isVisible: false, anchorRow: 0, anchorCol: 0)
        #expect(!config.hasOptions)
    }

    @Test("stores title correctly")
    func storesTitle() {
        let config = PopoverConfig(title: "Actions", options: ["A"], isVisible: true, anchorRow: 1, anchorCol: 2)
        #expect(config.title == "Actions")
    }

    @Test("stores anchor position")
    func storesAnchor() {
        let config = PopoverConfig(title: "T", options: [], isVisible: false, anchorRow: 7, anchorCol: 9)
        #expect(config.anchorRow == 7)
        #expect(config.anchorCol == 9)
    }

    @Test("visibility flag stored")
    func visibilityStored() {
        let visible = PopoverConfig(title: "V", options: ["X"], isVisible: true, anchorRow: 0, anchorCol: 0)
        let hidden = PopoverConfig(title: "H", options: ["X"], isVisible: false, anchorRow: 0, anchorCol: 0)
        #expect(visible.isVisible)
        #expect(!hidden.isVisible)
    }

    @Test("equality works for identical configs")
    func equalityWorks() {
        let a = PopoverConfig(title: "T", options: ["A", "B"], isVisible: true, anchorRow: 1, anchorCol: 2)
        let b = PopoverConfig(title: "T", options: ["A", "B"], isVisible: true, anchorRow: 1, anchorCol: 2)
        #expect(a == b)
    }
}
