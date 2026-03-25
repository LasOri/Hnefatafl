import Testing
@testable import Hnefatafl

@Suite("TempoCounter Tests")
struct TempoCounterTests {

    @Test("start position attacker tempo is positive")
    func startPositionAttackerTempo() {
        let position = Position.copenhagenStart()
        let count = TempoCounter.tempoCount(position: position, player: .attacker)
        #expect(count > 0)
    }

    @Test("start position defender tempo is positive")
    func startPositionDefenderTempo() {
        let position = Position.copenhagenStart()
        let count = TempoCounter.tempoCount(position: position, player: .defender)
        #expect(count > 0)
    }

    @Test("empty board returns zero for both")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(TempoCounter.tempoCount(position: position, player: .attacker) == 0)
        #expect(TempoCounter.tempoCount(position: position, player: .defender) == 0)
    }

    @Test("tempo lead is attacker minus defender")
    func tempoLeadCalculation() {
        let position = Position.copenhagenStart()
        let atkTempo = TempoCounter.tempoCount(position: position, player: .attacker)
        let defTempo = TempoCounter.tempoCount(position: position, player: .defender)
        #expect(TempoCounter.tempoLead(position: position) == atkTempo - defTempo)
    }

    @Test("single attacker near center has high tempo")
    func singleAttackerNearCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        let count = TempoCounter.tempoCount(position: position, player: .attacker)
        #expect(count >= 8)
    }

    @Test("single attacker on edge has lower tempo")
    func singleAttackerOnEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let edgeTempo = TempoCounter.tempoCount(position: position, player: .attacker)
        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .attacker
        let centerPos = Position(cells: cells2)
        let centerTempo = TempoCounter.tempoCount(position: centerPos, player: .attacker)
        #expect(centerTempo > edgeTempo)
    }
}
