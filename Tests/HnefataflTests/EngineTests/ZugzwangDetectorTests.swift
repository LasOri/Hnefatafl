import Testing
@testable import Hnefatafl

@Suite("ZugzwangDetector Tests")
struct ZugzwangDetectorTests {

    @Test("empty board is not zugzwang")
    func emptyBoardNotZugzwang() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(ZugzwangDetector.isZugzwang(position: position, player: .attacker) == false)
    }

    @Test("zugzwang score zero when no moves")
    func noMovesScoreZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = ZugzwangDetector.zugzwangScore(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("start position not zugzwang for attacker")
    func startNotZugzwangAttacker() {
        let position = Position.copenhagenStart()
        #expect(ZugzwangDetector.isZugzwang(position: position, player: .attacker) == false)
    }

    @Test("start position not zugzwang for defender")
    func startNotZugzwangDefender() {
        let position = Position.copenhagenStart()
        #expect(ZugzwangDetector.isZugzwang(position: position, player: .defender) == false)
    }

    @Test("zugzwang score is non-positive")
    func scoreNonPositive() {
        let position = Position.copenhagenStart()
        let score = ZugzwangDetector.zugzwangScore(position: position, player: .attacker)
        #expect(score <= 0)
    }

    @Test("single piece with moves not zugzwang")
    func singlePieceWithMoves() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let score = ZugzwangDetector.zugzwangScore(position: position, player: .attacker)
        #expect(score <= 0)
    }
}
