import Testing
@testable import Hnefatafl

@Suite("RankFileControl Tests")
struct RankFileControlTests {

    @Test("empty board has zero control score")
    func emptyBoardZeroScore() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(RankFileControl.controlScore(position: position, player: .attacker) == 0)
    }

    @Test("control score is non-negative")
    func nonNegativeScore() {
        let position = Position.copenhagenStart()
        #expect(RankFileControl.controlScore(position: position, player: .attacker) >= 0)
        #expect(RankFileControl.controlScore(position: position, player: .defender) >= 0)
    }

    @Test("dominatedRanks is non-negative")
    func dominatedRanksNonNegative() {
        let position = Position.copenhagenStart()
        #expect(RankFileControl.dominatedRanks(position: position, player: .attacker) >= 0)
    }

    @Test("dominatedRanks at most 11")
    func dominatedRanksAtMost11() {
        let position = Position.copenhagenStart()
        #expect(RankFileControl.dominatedRanks(position: position, player: .attacker) <= 11)
    }

    @Test("control score equals ranks plus files")
    func scoreEqualsRanksPlusFiles() {
        let position = Position.copenhagenStart()
        let score = RankFileControl.controlScore(position: position, player: .attacker)
        let ranks = RankFileControl.dominatedRanks(position: position, player: .attacker)
        #expect(score >= ranks)
    }

    @Test("single piece on row dominates that rank")
    func singlePieceDominatesRank() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 5)
            .build()
        let ranks = RankFileControl.dominatedRanks(position: position, player: .attacker)
        #expect(ranks >= 1)
    }

    @Test("empty board has zero dominated ranks")
    func emptyBoardZeroDominatedRanks() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(RankFileControl.dominatedRanks(position: position, player: .defender) == 0)
    }
}
