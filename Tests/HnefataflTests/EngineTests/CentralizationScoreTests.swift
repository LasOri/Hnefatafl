import Testing
@testable import Hnefatafl

@Suite("CentralizationScore Tests")
struct CentralizationScoreTests {
    @Test("Attacker centralization at start")
    func attackerCentralizationStart() {
        let position = Position.copenhagenStart()
        let score = CentralizationScore.score(position: position, player: .attacker)
        #expect(score > 0)
    }

    @Test("Defender centralization at start")
    func defenderCentralizationStart() {
        let position = Position.copenhagenStart()
        let score = CentralizationScore.score(position: position, player: .defender)
        #expect(score > 0)
    }

    @Test("Empty board has zero score")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = CentralizationScore.score(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("Average distance from center for empty board is zero")
    func emptyBoardAverageZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let avg = CentralizationScore.averageDistFromCenter(position: position, player: .attacker)
        #expect(avg == 0.0)
    }

    @Test("Single piece at center has zero average distance")
    func singlePieceCenter() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let avg = CentralizationScore.averageDistFromCenter(position: position, player: .attacker)
        #expect(avg == 0.0)
    }

    @Test("Piece at corner has max average distance")
    func singlePieceCorner() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let avg = CentralizationScore.averageDistFromCenter(position: position, player: .attacker)
        #expect(avg == 10.0)
    }

    @Test("King counts as defender for centralization")
    func kingCountsAsDefender() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let score = CentralizationScore.score(position: position, player: .defender)
        #expect(score > 0)
    }
}
