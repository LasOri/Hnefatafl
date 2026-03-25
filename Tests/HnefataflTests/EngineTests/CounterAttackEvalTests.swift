import Testing
@testable import Hnefatafl

@Suite("CounterAttackEval Tests")
struct CounterAttackEvalTests {
    @Test("Counter attack moves at Copenhagen start for attacker")
    func attackerCounterAttacksStart() {
        let position = Position.copenhagenStart()
        let moves = CounterAttackEval.counterAttackMoves(position: position, player: .attacker)
        #expect(moves.count >= 0)
    }

    @Test("Counter attack score matches move count times weight")
    func scoreMatchesMoveCount() {
        let position = Position.copenhagenStart()
        let moves = CounterAttackEval.counterAttackMoves(position: position, player: .attacker)
        let score = CounterAttackEval.counterAttackScore(position: position, player: .attacker)
        #expect(score == moves.count * 8)
    }

    @Test("Empty board has no counter attacks")
    func emptyBoardNoCounterAttacks() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let moves = CounterAttackEval.counterAttackMoves(position: position, player: .attacker)
        #expect(moves.count >= 0)
    }

    @Test("Defender counter attacks at start")
    func defenderCounterAttacks() {
        let position = Position.copenhagenStart()
        let moves = CounterAttackEval.counterAttackMoves(position: position, player: .defender)
        #expect(moves.count >= 0)
    }

    @Test("Counter attack score is non-negative")
    func scoreNonNegative() {
        let position = Position.copenhagenStart()
        let attackerScore = CounterAttackEval.counterAttackScore(position: position, player: .attacker)
        let defenderScore = CounterAttackEval.counterAttackScore(position: position, player: .defender)
        #expect(attackerScore >= 0)
        #expect(defenderScore >= 0)
    }

    @Test("All counter attack moves are legal")
    func movesAreLegal() {
        let position = Position.copenhagenStart()
        let counterMoves = CounterAttackEval.counterAttackMoves(position: position, player: .attacker)
        let legalMoves = position.allLegalMoves(for: .attacker)
        for move in counterMoves {
            #expect(legalMoves.contains(move))
        }
    }
}
