import Testing
@testable import Hnefatafl

@Suite("Move Validation Result Tests")
struct MoveValidationResultTests {

    @Test("valid move returns valid status")
    func validMoveReturnsValid() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = MoveValidationResult.validate(move: move, position: position)
        #expect(result.status == .valid)
        #expect(result.move == move)
    }

    @Test("out of bounds returns invalid")
    func outOfBoundsInvalid() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: -1, fromCol: 0, toRow: 0, toCol: 0)
        let result = MoveValidationResult.validate(move: move, position: position)
        #expect(result.status == .invalid("Out of bounds"))
        #expect(result.move == nil)
    }

    @Test("no piece at source returns invalid")
    func noPieceAtSourceInvalid() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let result = MoveValidationResult.validate(move: move, position: position)
        #expect(result.status == .invalid("No piece at source"))
    }

    @Test("destination occupied returns invalid")
    func destinationOccupiedInvalid() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let result = MoveValidationResult.validate(move: move, position: position)
        #expect(result.status == .invalid("Destination occupied"))
    }

    @Test("illegal move returns invalid")
    func illegalMoveInvalid() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 1, toCol: 4)
        let result = MoveValidationResult.validate(move: move, position: position)
        #expect(result.status == .invalid("Not a legal move"))
    }

    @Test("MoveValidationStatus equatable")
    func statusEquatable() {
        let a: MoveValidationStatus = .valid
        let b: MoveValidationStatus = .valid
        #expect(a == b)
        let c: MoveValidationStatus = .invalid("test")
        let d: MoveValidationStatus = .invalid("test")
        #expect(c == d)
    }

    @Test("result is equatable")
    func resultEquatable() {
        let a = MoveValidationResult(status: .valid, move: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0))
        let b = MoveValidationResult(status: .valid, move: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0))
        #expect(a == b)
    }
}
