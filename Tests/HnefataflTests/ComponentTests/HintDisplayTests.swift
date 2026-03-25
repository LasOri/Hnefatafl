import Testing
@testable import Hnefatafl

@Suite("Hint Display Tests")
struct HintDisplayTests {

    @Test("hasHint is true when suggestedMove is present")
    func hasHintTrue() {
        let hint = HintDisplay(
            suggestedMove: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1),
            hintText: "Try this move",
            isVisible: true
        )
        #expect(hint.hasHint == true)
    }

    @Test("hasHint is false when suggestedMove is nil")
    func hasHintFalse() {
        let hint = HintDisplay(suggestedMove: nil, hintText: "No hint", isVisible: false)
        #expect(hint.hasHint == false)
    }

    @Test("stores hint text")
    func storesHintText() {
        let hint = HintDisplay(suggestedMove: nil, hintText: "Move the king", isVisible: true)
        #expect(hint.hintText == "Move the king")
    }

    @Test("stores visibility")
    func storesVisibility() {
        let hint = HintDisplay(suggestedMove: nil, hintText: "", isVisible: true)
        #expect(hint.isVisible == true)
    }

    @Test("equatable with same values")
    func equatable() {
        let a = HintDisplay(suggestedMove: nil, hintText: "Hint", isVisible: false)
        let b = HintDisplay(suggestedMove: nil, hintText: "Hint", isVisible: false)
        #expect(a == b)
    }

    @Test("different texts are not equal")
    func differentTexts() {
        let a = HintDisplay(suggestedMove: nil, hintText: "A", isVisible: false)
        let b = HintDisplay(suggestedMove: nil, hintText: "B", isVisible: false)
        #expect(a != b)
    }

    @Test("stores suggested move")
    func storesMove() {
        let move = Move(fromRow: 1, fromCol: 2, toRow: 3, toCol: 2)
        let hint = HintDisplay(suggestedMove: move, hintText: "", isVisible: true)
        #expect(hint.suggestedMove == move)
    }
}
