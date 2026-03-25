import Testing
@testable import Hnefatafl

@Suite("Dropdown Config Tests")
struct DropdownConfigTests {

    @Test("selected option returns correct value")
    func selectedOptionCorrect() {
        let config = DropdownConfig(options: ["Easy", "Medium", "Hard"], selectedIndex: 1, isOpen: false, label: "Difficulty")
        #expect(config.selectedOption == "Medium")
    }

    @Test("out of range index returns nil")
    func outOfRangeNil() {
        let config = DropdownConfig(options: ["A", "B"], selectedIndex: 5, isOpen: false, label: "Test")
        #expect(config.selectedOption == nil)
    }

    @Test("negative index returns nil")
    func negativeIndexNil() {
        let config = DropdownConfig(options: ["A", "B"], selectedIndex: -1, isOpen: false, label: "Test")
        #expect(config.selectedOption == nil)
    }

    @Test("has selection when index valid")
    func hasSelectionValid() {
        let config = DropdownConfig(options: ["X"], selectedIndex: 0, isOpen: false, label: "Pick")
        #expect(config.hasSelection)
    }

    @Test("no selection when index out of range")
    func noSelectionOutOfRange() {
        let config = DropdownConfig(options: [], selectedIndex: 0, isOpen: false, label: "Empty")
        #expect(!config.hasSelection)
    }

    @Test("configs are equatable")
    func equatable() {
        let a = DropdownConfig(options: ["A", "B"], selectedIndex: 0, isOpen: false, label: "Test")
        let b = DropdownConfig(options: ["A", "B"], selectedIndex: 0, isOpen: false, label: "Test")
        #expect(a == b)
    }

    @Test("different open state makes configs unequal")
    func differentOpenState() {
        let a = DropdownConfig(options: ["A"], selectedIndex: 0, isOpen: true, label: "Test")
        let b = DropdownConfig(options: ["A"], selectedIndex: 0, isOpen: false, label: "Test")
        #expect(a != b)
    }
}
