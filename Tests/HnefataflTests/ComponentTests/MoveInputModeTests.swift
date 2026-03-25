import Testing
@testable import Hnefatafl

@Suite("Move Input Mode Tests")
struct MoveInputModeTests {

    @Test("click mode creation")
    func clickMode() {
        let mode = MoveInputMode(inputType: .click, confirmRequired: false)
        #expect(mode.inputType == .click)
        #expect(mode.confirmRequired == false)
    }

    @Test("drag mode with confirmation")
    func dragWithConfirm() {
        let mode = MoveInputMode(inputType: .drag, confirmRequired: true)
        #expect(mode.inputType == .drag)
        #expect(mode.confirmRequired == true)
    }

    @Test("keyboard mode creation")
    func keyboardMode() {
        let mode = MoveInputMode(inputType: .keyboard, confirmRequired: true)
        #expect(mode.inputType == .keyboard)
    }

    @Test("MoveInputType has three cases")
    func inputTypeCases() {
        #expect(MoveInputType.allCases.count == 3)
    }

    @Test("MoveInputType raw values")
    func rawValues() {
        #expect(MoveInputType.click.rawValue == "click")
        #expect(MoveInputType.drag.rawValue == "drag")
        #expect(MoveInputType.keyboard.rawValue == "keyboard")
    }

    @Test("equatable compares all fields")
    func equatable() {
        let a = MoveInputMode(inputType: .click, confirmRequired: false)
        let b = MoveInputMode(inputType: .click, confirmRequired: false)
        #expect(a == b)
    }

    @Test("different confirm required are not equal")
    func differentConfirm() {
        let a = MoveInputMode(inputType: .click, confirmRequired: false)
        let b = MoveInputMode(inputType: .click, confirmRequired: true)
        #expect(a != b)
    }
}
