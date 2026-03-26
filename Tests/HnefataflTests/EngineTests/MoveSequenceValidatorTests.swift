import Testing
@testable import Hnefatafl

@Suite("MoveSequenceValidator Tests")
struct MoveSequenceValidatorTests {

    @Test("empty sequence is valid")
    func emptySequence() {
        let pos = Position.copenhagenStart()
        let result = MoveSequenceValidator.validate(moves: [], from: pos, startingPlayer: .attacker)
        #expect(result.isValid)
    }

    @Test("single legal move is valid")
    func singleLegalMove() {
        let pos = Position.copenhagenStart()
        let move = pos.allLegalMoves(for: .attacker).first!
        let result = MoveSequenceValidator.validate(moves: [move], from: pos, startingPlayer: .attacker)
        #expect(result.isValid)
    }

    @Test("illegal move is invalid")
    func illegalMove() {
        let pos = Position.copenhagenStart()
        let badMove = Move(fromRow: 0, fromCol: 0, toRow: 5, toCol: 5)
        let result = MoveSequenceValidator.validate(moves: [badMove], from: pos, startingPlayer: .attacker)
        #expect(!result.isValid)
    }

    @Test("validation returns failing index")
    func failingIndex() {
        let pos = Position.copenhagenStart()
        let goodMove = pos.allLegalMoves(for: .attacker).first!
        let badMove = Move(fromRow: 0, fromCol: 0, toRow: 10, toCol: 10)
        let result = MoveSequenceValidator.validate(moves: [goodMove, badMove], from: pos, startingPlayer: .attacker)
        #expect(!result.isValid)
        #expect(result.failingIndex == 1)
    }

    @Test("two alternating legal moves are valid")
    func twoMoves() {
        let pos = Position.copenhagenStart()
        let attackMove = pos.allLegalMoves(for: .attacker).first!
        let pos2 = pos.applyMove(attackMove)
        let defenseMove = pos2.allLegalMoves(for: .defender).first!
        let result = MoveSequenceValidator.validate(moves: [attackMove, defenseMove], from: pos, startingPlayer: .attacker)
        #expect(result.isValid)
    }

    @Test("result tracks move count")
    func moveCount() {
        let pos = Position.copenhagenStart()
        let move = pos.allLegalMoves(for: .attacker).first!
        let result = MoveSequenceValidator.validate(moves: [move], from: pos, startingPlayer: .attacker)
        #expect(result.validMoveCount == 1)
    }

    @Test("SequenceValidationResult is Equatable")
    func equatable() {
        let a = SequenceValidationResult(isValid: true, failingIndex: nil, validMoveCount: 0)
        let b = SequenceValidationResult(isValid: true, failingIndex: nil, validMoveCount: 0)
        #expect(a == b)
    }
}
