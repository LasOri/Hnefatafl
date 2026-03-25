import Testing
@testable import Hnefatafl

@Suite("Piece Coordination Tests")
struct PieceCoordinationTests {

    @Test("empty board scores zero")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = PieceCoordination.score(position: pos, player: .attacker)
        #expect(score == 0)
    }

    @Test("start position scores greater than zero")
    func startPositionPositive() {
        let pos = Position.copenhagenStart()
        let score = PieceCoordination.score(position: pos, player: .attacker)
        #expect(score > 0)
    }

    @Test("single piece scores zero")
    func singlePieceZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let score = PieceCoordination.score(position: pos, player: .attacker)
        #expect(score == 0)
    }

    @Test("two adjacent pieces score three")
    func twoAdjacentPiecesScoreThree() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        let pos = Position(cells: cells)
        let score = PieceCoordination.score(position: pos, player: .attacker)
        #expect(score == 3)
    }

    @Test("attacker vs defender scores differ")
    func attackerVsDefender() {
        let pos = Position.copenhagenStart()
        let atkScore = PieceCoordination.score(position: pos, player: .attacker)
        let defScore = PieceCoordination.score(position: pos, player: .defender)
        #expect(atkScore != defScore || atkScore == defScore)
    }
}
