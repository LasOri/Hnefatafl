import Testing
@testable import Hnefatafl

@Suite("PieceCountDisplay Tests")
struct PieceCountDisplayTests {

    @Test("start position has 24 attackers")
    func startPositionAttackers() {
        let position = Position.copenhagenStart()
        let data = PieceCountDisplay.data(for: position)
        #expect(data.attackers == 24)
    }

    @Test("start position has 13 defenders including king")
    func startPositionDefenders() {
        let position = Position.copenhagenStart()
        let data = PieceCountDisplay.data(for: position)
        #expect(data.defenders == 13)
    }

    @Test("king alive at start")
    func kingAliveAtStart() {
        let position = Position.copenhagenStart()
        let data = PieceCountDisplay.data(for: position)
        #expect(data.kingAlive == true)
    }

    @Test("advantage is attackers minus defenders")
    func advantageCalculation() {
        let position = Position.copenhagenStart()
        let data = PieceCountDisplay.data(for: position)
        #expect(data.advantage == data.attackers - data.defenders)
    }

    @Test("empty board has zeros")
    func emptyBoardZeros() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let data = PieceCountDisplay.data(for: position)
        #expect(data.attackers == 0)
        #expect(data.defenders == 0)
        #expect(data.kingAlive == false)
        #expect(data.advantage == 0)
    }
}
