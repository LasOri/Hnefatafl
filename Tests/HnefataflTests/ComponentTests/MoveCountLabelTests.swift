import Testing
@testable import Hnefatafl

@Suite("MoveCountLabel Tests")
struct MoveCountLabelTests {
    @Test("Display text without total")
    func displayWithoutTotal() {
        let label = MoveCountLabel(current: 5, total: nil)
        #expect(label.displayText == "Move 5")
    }

    @Test("Display text with total")
    func displayWithTotal() {
        let label = MoveCountLabel(current: 5, total: 50)
        #expect(label.displayText == "Move 5 / 50")
    }

    @Test("hasTotal is false when nil")
    func hasTotalFalse() {
        let label = MoveCountLabel(current: 1, total: nil)
        #expect(!label.hasTotal)
    }

    @Test("hasTotal is true when set")
    func hasTotalTrue() {
        let label = MoveCountLabel(current: 1, total: 100)
        #expect(label.hasTotal)
    }

    @Test("Labels are equatable")
    func equatable() {
        let a = MoveCountLabel(current: 3, total: 10)
        let b = MoveCountLabel(current: 3, total: 10)
        #expect(a == b)
    }

    @Test("Different labels are not equal")
    func notEqual() {
        let a = MoveCountLabel(current: 3, total: 10)
        let b = MoveCountLabel(current: 4, total: 10)
        #expect(a != b)
    }

    @Test("Move 1 display text is correct")
    func moveOneDisplay() {
        let label = MoveCountLabel(current: 1, total: nil)
        #expect(label.displayText == "Move 1")
    }
}
