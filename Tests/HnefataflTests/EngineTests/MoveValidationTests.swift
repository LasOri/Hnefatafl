import Testing
@testable import Hnefatafl

@Suite("Move Validation Tests")
struct MoveValidationTests {

    @Test("validates legal move returns nil reason")
    func legalMoveNil() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == nil)
    }

    @Test("rejects move to occupied square")
    func rejectsOccupied() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == .blocked)
    }

    @Test("rejects diagonal move")
    func rejectsDiagonal() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 1, toCol: 4)
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == .diagonal)
    }

    @Test("rejects no-op move (same square)")
    func rejectsSameSquare() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 3)
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == .noMovement)
    }

    @Test("InvalidMoveReason has descriptive message")
    func reasonMessages() {
        #expect(!InvalidMoveReason.blocked.message.isEmpty)
        #expect(!InvalidMoveReason.diagonal.message.isEmpty)
        #expect(!InvalidMoveReason.noMovement.message.isEmpty)
        #expect(!InvalidMoveReason.outOfBounds.message.isEmpty)
    }

    @Test("rejects out-of-bounds move")
    func rejectsOutOfBounds() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: -1, toCol: 3)
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == .outOfBounds)
    }

    @Test("shake animation CSS exists")
    func shakeCSS() {
        #expect(GameStyleSheet.css.contains("shake"))
    }

    @Test("rejects move when path is blocked")
    func rejectsPathBlocked() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 8)
        let reason = MoveValidator.validate(move: move, in: game)
        #expect(reason == .blocked)
    }
}
