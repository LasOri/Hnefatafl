import Testing
@testable import Hnefatafl

@Suite("BoardEdgeControl Tests")
struct BoardEdgeControlTests {
    @Test("EdgeControl initialization")
    func edgeControlInit() {
        let control = EdgeControl(top: 1, bottom: 2, left: 3, right: 4)
        #expect(control.top == 1)
        #expect(control.bottom == 2)
        #expect(control.left == 3)
        #expect(control.right == 4)
    }

    @Test("Attacker edge control at start")
    func attackerEdgeStart() {
        let position = Position.copenhagenStart()
        let control = BoardEdgeControl.edgeControl(position: position, player: .attacker)
        #expect(control.top >= 0)
        #expect(control.bottom >= 0)
        #expect(control.left >= 0)
        #expect(control.right >= 0)
    }

    @Test("Defender edge control at start")
    func defenderEdgeStart() {
        let position = Position.copenhagenStart()
        let control = BoardEdgeControl.edgeControl(position: position, player: .defender)
        #expect(control.top >= 0)
        #expect(control.bottom >= 0)
        #expect(control.left >= 0)
        #expect(control.right >= 0)
    }

    @Test("Dominant edge")
    func dominantEdge() {
        let position = Position.copenhagenStart()
        let control = BoardEdgeControl.edgeControl(position: position, player: .attacker)
        let dominant = control.dominantEdge
        #expect(dominant >= 0)
    }

    @Test("Total control")
    func totalControl() {
        let position = Position.copenhagenStart()
        let control = BoardEdgeControl.edgeControl(position: position, player: .attacker)
        let total = control.totalControl
        #expect(total == control.top + control.bottom + control.left + control.right)
    }

    @Test("Empty position has zero control")
    func emptyPosition() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let control = BoardEdgeControl.edgeControl(position: emptyPosition, player: .attacker)
        #expect(control.top == 0)
        #expect(control.bottom == 0)
        #expect(control.left == 0)
        #expect(control.right == 0)
        #expect(control.totalControl == 0)
    }

    @Test("Edge control is symmetric for attackers")
    func symmetricAttacker() {
        let position = Position.copenhagenStart()
        let control = BoardEdgeControl.edgeControl(position: position, player: .attacker)
        #expect(control.top == control.bottom)
        #expect(control.left == control.right)
    }
}
