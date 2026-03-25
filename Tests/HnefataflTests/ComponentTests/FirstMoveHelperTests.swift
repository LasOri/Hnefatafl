import Testing
@testable import Hnefatafl

@Suite("First Move Helper Tests")
struct FirstMoveHelperTests {

    @Test("attacker suggestion has advance reason")
    func attackerReason() {
        let position = Position.copenhagenStart()
        let suggestion = FirstMoveHelper.suggest(position: position, player: .attacker)
        #expect(suggestion != nil)
        #expect(suggestion!.reason == "Advance toward the center")
    }

    @Test("defender suggestion has protect reason")
    func defenderReason() {
        let position = Position.copenhagenStart()
        let suggestion = FirstMoveHelper.suggest(position: position, player: .defender)
        #expect(suggestion != nil)
        #expect(suggestion!.reason == "Protect the king")
    }

    @Test("suggestion returns a valid move")
    func validMove() {
        let position = Position.copenhagenStart()
        let suggestion = FirstMoveHelper.suggest(position: position, player: .attacker)!
        let allMoves = position.allLegalMoves(for: .attacker)
        #expect(allMoves.contains(suggestion.move))
    }

    @Test("no moves returns nil")
    func noMovesReturnsNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let suggestion = FirstMoveHelper.suggest(position: position, player: .attacker)
        #expect(suggestion == nil)
    }

    @Test("FirstMoveSuggestion supports equality")
    func suggestionEquality() {
        let m = Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)
        let a = FirstMoveSuggestion(move: m, reason: "test")
        let b = FirstMoveSuggestion(move: m, reason: "test")
        #expect(a == b)
    }
}
