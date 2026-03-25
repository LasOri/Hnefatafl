import Testing
@testable import Hnefatafl

@Suite("Flexibility Score Tests")
struct FlexibilityScoreTests {

    @Test("empty board returns zero")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(FlexibilityScore.score(position: pos, player: .attacker) == 0)
    }

    @Test("start position attacker has positive flexibility")
    func startPositionAttackerPositive() {
        let pos = Position.copenhagenStart()
        #expect(FlexibilityScore.score(position: pos, player: .attacker) > 0)
    }

    @Test("start position defender has positive flexibility")
    func startPositionDefenderPositive() {
        let pos = Position.copenhagenStart()
        #expect(FlexibilityScore.score(position: pos, player: .defender) > 0)
    }

    @Test("isFlexible returns true above threshold")
    func isFlexibleAboveThreshold() {
        let pos = Position.copenhagenStart()
        #expect(FlexibilityScore.isFlexible(position: pos, player: .attacker, threshold: 1))
    }

    @Test("isFlexible returns false at high threshold")
    func isFlexibleHighThreshold() {
        let pos = Position.copenhagenStart()
        #expect(!FlexibilityScore.isFlexible(position: pos, player: .attacker, threshold: 999))
    }

    @Test("single piece has limited flexibility")
    func singlePieceLimited() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let s = FlexibilityScore.score(position: pos, player: .attacker)
        #expect(s > 0)
    }
}
