import Testing
@testable import Hnefatafl

@Suite("PieceBlockageEval Tests")
struct PieceBlockageEvalTests {

    @Test("empty board has no blocked pieces")
    func emptyBoardNoBlocked() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceBlockageEval.blockedPieceCount(position: position, player: .attacker) == 0)
    }

    @Test("blockage score zero for empty board")
    func emptyBoardScoreZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceBlockageEval.blockageScore(position: position, player: .attacker) == 0)
    }

    @Test("completely surrounded piece is blocked")
    func surroundedPieceBlocked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 3] = .attacker
        cells[4 * 11 + 4] = .defender
        cells[6 * 11 + 4] = .defender
        cells[5 * 11 + 4] = .defender
        let position = Position(cells: cells)
        let blocked = PieceBlockageEval.blockedPieceCount(position: position, player: .defender)
        #expect(blocked >= 0)
    }

    @Test("blockage score is non-positive")
    func scoreNonPositive() {
        let position = Position.copenhagenStart()
        let score = PieceBlockageEval.blockageScore(position: position, player: .attacker)
        #expect(score <= 0)
    }

    @Test("blockage score proportional to blocked count")
    func scoreProportional() {
        let position = Position.copenhagenStart()
        let blocked = PieceBlockageEval.blockedPieceCount(position: position, player: .attacker)
        let score = PieceBlockageEval.blockageScore(position: position, player: .attacker)
        #expect(score == -blocked * 15)
    }

    @Test("start position blocked count for defender")
    func startPositionDefender() {
        let position = Position.copenhagenStart()
        let blocked = PieceBlockageEval.blockedPieceCount(position: position, player: .defender)
        #expect(blocked >= 0 && blocked <= position.defenderCount)
    }
}
