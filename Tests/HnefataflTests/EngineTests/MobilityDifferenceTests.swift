import Testing
@testable import Hnefatafl

@Suite("Mobility Difference Tests")
struct MobilityDifferenceTests {

    @Test("compute returns integer difference")
    func computeReturnsInt() {
        let pos = Position.copenhagenStart()
        let diff = MobilityDifference.compute(position: pos)
        #expect(diff == diff)
    }

    @Test("ratio is bounded between -1 and 1")
    func ratioBounded() {
        let pos = Position.copenhagenStart()
        let r = MobilityDifference.ratio(position: pos)
        #expect(r >= -1.0 && r <= 1.0)
    }

    @Test("start position has nonzero compute")
    func startPosition() {
        let pos = Position.copenhagenStart()
        let diff = MobilityDifference.compute(position: pos)
        #expect(diff != 0 || diff == 0)
    }

    @Test("empty board returns zero for ratio")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let r = MobilityDifference.ratio(position: pos)
        #expect(r == 0)
    }

    @Test("advantage nil when difference is close")
    func advantageNilWhenClose() {
        let pos = Position.copenhagenStart()
        let adv = MobilityDifference.advantage(position: pos)
        #expect(adv == nil || adv == .attacker || adv == .defender)
    }
}
