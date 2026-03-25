import Testing
@testable import Hnefatafl

@Suite("CaptureCounter Tests")
struct CaptureCounterTests {

    @Test("no captures at start position")
    func noCapturesAtStart() {
        let position = Position.copenhagenStart()
        let result = CaptureCounter.count(initialAttackers: 24, initialDefenders: 13, position: position)
        #expect(result.attackerCaptures == 0)
        #expect(result.defenderCaptures == 0)
    }

    @Test("from start position returns zeros")
    func fromStartPositionZeros() {
        let position = Position.copenhagenStart()
        let result = CaptureCounter.fromStartPosition(currentPosition: position)
        #expect(result.attackerCaptures == 0)
        #expect(result.defenderCaptures == 0)
    }

    @Test("counts after attacker removed")
    func countsAfterAttackerRemoved() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        for i in 0..<23 {
            cells[i] = .attacker
        }
        for i in 100..<112 {
            cells[i] = .defender
        }
        let position = Position(cells: cells)
        let result = CaptureCounter.count(initialAttackers: 24, initialDefenders: 13, position: position)
        #expect(result.defenderCaptures == 1)
    }

    @Test("counts after defender removed")
    func countsAfterDefenderRemoved() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        for i in 0..<24 {
            cells[i] = .attacker
        }
        for i in 100..<111 {
            cells[i] = .defender
        }
        let position = Position(cells: cells)
        let result = CaptureCounter.count(initialAttackers: 24, initialDefenders: 13, position: position)
        #expect(result.attackerCaptures == 1)
    }

    @Test("captures attributed to correct player")
    func capturesAttributedCorrectly() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        for i in 0..<22 {
            cells[i] = .attacker
        }
        for i in 100..<111 {
            cells[i] = .defender
        }
        let position = Position(cells: cells)
        let result = CaptureCounter.count(initialAttackers: 24, initialDefenders: 13, position: position)
        #expect(result.defenderCaptures == 2)
        #expect(result.attackerCaptures == 1)
    }
}
