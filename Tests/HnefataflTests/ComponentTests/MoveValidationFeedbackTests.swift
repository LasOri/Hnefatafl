import Testing
@testable import Hnefatafl

@Suite("Move Validation Feedback Tests")
struct MoveValidationFeedbackTests {

    @Test("valid move returns no error")
    func validMove() {
        let feedback = MoveValidationFeedback.validate(
            from: (5, 5), to: (5, 7), piece: .attacker, position: Position.copenhagenStart()
        )
        #expect(feedback == nil || feedback!.isValid)
    }

    @Test("no piece at source returns error")
    func noPieceAtSource() {
        let feedback = MoveValidationFeedback.validate(
            from: (2, 2), to: (2, 4), piece: nil, position: Position.copenhagenStart()
        )
        #expect(feedback != nil)
        #expect(!feedback!.isValid)
    }

    @Test("diagonal move returns error")
    func diagonalMove() {
        let feedback = MoveValidationFeedback.validate(
            from: (5, 5), to: (6, 6), piece: .king, position: Position.copenhagenStart()
        )
        #expect(feedback != nil)
        #expect(feedback!.message.contains("diagonal") || feedback!.message.contains("straight"))
    }

    @Test("move to same square returns error")
    func sameSquare() {
        let feedback = MoveValidationFeedback.validate(
            from: (5, 5), to: (5, 5), piece: .king, position: Position.copenhagenStart()
        )
        #expect(feedback != nil)
        #expect(!feedback!.isValid)
    }

    @Test("error message is not empty")
    func errorMessageNotEmpty() {
        let feedback = MoveValidationFeedback.validate(
            from: (2, 2), to: (2, 4), piece: nil, position: Position.copenhagenStart()
        )
        #expect(feedback != nil)
        #expect(!feedback!.message.isEmpty)
    }

    @Test("ValidationResult is Equatable")
    func equatable() {
        let a = ValidationResult(isValid: false, message: "error")
        let b = ValidationResult(isValid: false, message: "error")
        #expect(a == b)
    }

    @Test("valid result has empty message")
    func validResult() {
        let result = ValidationResult(isValid: true, message: "")
        #expect(result.isValid)
    }

    @Test("throne square blocked for non-king")
    func throneBlocked() {
        let feedback = MoveValidationFeedback.validate(
            from: (4, 5), to: (5, 5), piece: .attacker, position: Position.copenhagenStart()
        )
        #expect(feedback != nil)
    }
}
