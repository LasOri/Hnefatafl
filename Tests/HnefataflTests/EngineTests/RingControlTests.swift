import Testing
@testable import Hnefatafl

@Suite("RingControl Tests")
struct RingControlTests {
    @Test("Empty board inner ring is zero")
    func emptyInnerRing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = RingControl.innerRingScore(position: position)
        #expect(score == 0)
    }

    @Test("Attacker in center gives positive inner ring score")
    func attackerInCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let score = RingControl.innerRingScore(position: position)
        #expect(score > 0)
    }

    @Test("Defender in center gives negative inner ring score")
    func defenderInCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let score = RingControl.innerRingScore(position: position)
        #expect(score < 0)
    }

    @Test("Outer ring score for empty board is zero")
    func emptyOuterRing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = RingControl.outerRingScore(position: position)
        #expect(score == 0)
    }

    @Test("Attacker on edge gives positive outer ring score")
    func attackerOnEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let score = RingControl.outerRingScore(position: position)
        #expect(score > 0)
    }

    @Test("Start position has nonzero inner ring")
    func startInnerRing() {
        let position = Position.copenhagenStart()
        let score = RingControl.innerRingScore(position: position)
        #expect(score != 0)
    }
}
