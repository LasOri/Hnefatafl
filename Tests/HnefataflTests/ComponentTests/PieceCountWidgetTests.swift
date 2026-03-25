import Testing
@testable import Hnefatafl

@Suite("PieceCountWidget Tests")
struct PieceCountWidgetTests {
    @Test("Difference text when attackers lead")
    func attackersLead() {
        let widget = PieceCountWidget(attackers: 24, defenders: 12, kingPresent: true, showDiff: true)
        #expect(widget.differenceText == "+12 attacker")
    }

    @Test("Difference text when defenders lead")
    func defendersLead() {
        let widget = PieceCountWidget(attackers: 10, defenders: 13, kingPresent: true, showDiff: true)
        #expect(widget.differenceText == "+3 defender")
    }

    @Test("Difference text when even")
    func evenCount() {
        let widget = PieceCountWidget(attackers: 12, defenders: 12, kingPresent: true, showDiff: true)
        #expect(widget.differenceText == "Even")
    }

    @Test("Difference text empty when showDiff is false")
    func showDiffFalse() {
        let widget = PieceCountWidget(attackers: 24, defenders: 12, kingPresent: true, showDiff: false)
        #expect(widget.differenceText == "")
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = PieceCountWidget(attackers: 24, defenders: 12, kingPresent: true, showDiff: true)
        let b = PieceCountWidget(attackers: 24, defenders: 12, kingPresent: true, showDiff: true)
        #expect(a == b)
    }

    @Test("Stores all properties")
    func storesProperties() {
        let widget = PieceCountWidget(attackers: 20, defenders: 10, kingPresent: false, showDiff: true)
        #expect(widget.attackers == 20)
        #expect(widget.defenders == 10)
        #expect(widget.kingPresent == false)
        #expect(widget.showDiff == true)
    }
}
