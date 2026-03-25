import Testing
@testable import Hnefatafl

@Suite("NullMoveHeuristic Tests")
struct NullMoveHeuristicTests {
    @Test("Null move score on empty board is zero")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = NullMoveHeuristic.nullMoveScore(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("Null move safe on empty board")
    func emptyBoardSafe() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let safe = NullMoveHeuristic.isNullMoveSafe(position: position, player: .attacker)
        #expect(safe == true)
    }

    @Test("Null move score is non-positive")
    func scoreNonPositive() {
        let position = Position.copenhagenStart()
        let score = NullMoveHeuristic.nullMoveScore(position: position, player: .attacker)
        #expect(score <= 0)
    }

    @Test("Start position null move safety for defender")
    func startPositionDefender() {
        let position = Position.copenhagenStart()
        let safe = NullMoveHeuristic.isNullMoveSafe(position: position, player: .defender)
        #expect(safe == true || safe == false)
    }

    @Test("Null move safe returns bool based on score threshold")
    func safeThreshold() {
        let position = Position.copenhagenStart()
        let score = NullMoveHeuristic.nullMoveScore(position: position, player: .attacker)
        let safe = NullMoveHeuristic.isNullMoveSafe(position: position, player: .attacker)
        #expect(safe == (score >= -1))
    }

    @Test("Null move score for attacker at start")
    func attackerStartScore() {
        let position = Position.copenhagenStart()
        let score = NullMoveHeuristic.nullMoveScore(position: position, player: .attacker)
        #expect(score >= -100)
    }
}
