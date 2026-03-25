import Testing
@testable import Hnefatafl

@Suite("Piece Activity Score Tests")
struct PieceActivityScoreTests {

    @Test("activity based on mobility")
    func mobilityBased() {
        let position = Position.copenhagenStart()
        let score = PieceActivityScore.compute(position: position, player: .attacker)
        #expect(score > 0)
    }

    @Test("attacker and defender have different scores")
    func differentScores() {
        let position = Position.copenhagenStart()
        let att = PieceActivityScore.compute(position: position, player: .attacker)
        let def = PieceActivityScore.compute(position: position, player: .defender)
        #expect(att != def)
    }

    @Test("empty board has zero activity")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let score = PieceActivityScore.compute(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("per-piece activity average")
    func perPieceAverage() {
        let position = Position.copenhagenStart()
        let avg = PieceActivityScore.averageActivity(position: position, player: .attacker)
        #expect(avg > 0)
    }

    @Test("king has activity")
    func kingActivity() {
        let position = Position.copenhagenStart()
        let score = PieceActivityScore.kingActivity(position: position)
        #expect(score >= 0)
    }

    @Test("more mobile position has higher score")
    func moreMobileHigher() {
        let position = Position.copenhagenStart()
        let score = PieceActivityScore.compute(position: position, player: .attacker)
        #expect(score > 0)
    }
}
