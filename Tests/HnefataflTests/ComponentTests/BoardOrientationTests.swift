import Testing
@testable import Hnefatafl

@Suite("Board Orientation Tests")
struct BoardOrientationTests {

    @Test("effective for auto with attacker")
    func autoWithAttacker() {
        let result = BoardOrientation.effectiveOrientation(selected: .auto, currentPlayer: .attacker)
        #expect(result == .attackerBottom)
    }

    @Test("effective for auto with defender")
    func autoWithDefender() {
        let result = BoardOrientation.effectiveOrientation(selected: .auto, currentPlayer: .defender)
        #expect(result == .defenderBottom)
    }

    @Test("should flip when defender bottom")
    func shouldFlipDefenderBottom() {
        #expect(BoardOrientation.shouldFlip(orientation: .defenderBottom) == true)
        #expect(BoardOrientation.shouldFlip(orientation: .attackerBottom) == false)
    }

    @Test("next cycles through all orientations")
    func nextCycles() {
        let first = BoardOrientation.next(after: .attackerBottom)
        let second = BoardOrientation.next(after: first)
        let third = BoardOrientation.next(after: second)
        #expect(third == .attackerBottom)
    }

    @Test("three orientations available")
    func threeOrientations() {
        #expect(Orientation.allCases.count == 3)
    }
}
