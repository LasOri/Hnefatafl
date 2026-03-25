import Testing
@testable import Hnefatafl

@Suite("PositionValidator Tests")
struct PositionValidatorTests {

    @Test("starting position is valid")
    func startValid() {
        let result = PositionValidator.validate(Position.copenhagenStart())
        #expect(result.isValid)
        #expect(result.errors.isEmpty)
    }

    @Test("empty position is invalid — no king")
    func emptyInvalid() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let result = PositionValidator.validate(pos)
        #expect(!result.isValid)
        #expect(result.errors.contains(.noKing))
    }

    @Test("position with two kings is invalid")
    func twoKings() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .king
        let result = PositionValidator.validate(Position(cells: cells))
        #expect(!result.isValid)
        #expect(result.errors.contains(.multipleKings))
    }

    @Test("position with exactly one king and attackers is valid")
    func minimalValid() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        cells[0] = .attacker
        let result = PositionValidator.validate(Position(cells: cells))
        #expect(result.isValid)
    }

    @Test("position with too many attackers is invalid")
    func tooManyAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        for i in 0..<30 {
            cells[i] = .attacker
        }
        let result = PositionValidator.validate(Position(cells: cells))
        #expect(!result.isValid)
        #expect(result.errors.contains(.tooManyAttackers))
    }

    @Test("position with too many defenders is invalid")
    func tooManyDefenders() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        for i in 0..<15 {
            cells[61 + i] = .defender
        }
        let result = PositionValidator.validate(Position(cells: cells))
        #expect(!result.isValid)
        #expect(result.errors.contains(.tooManyDefenders))
    }

    @Test("ValidationError is Equatable")
    func errorEquatable() {
        #expect(ValidationError.noKing == ValidationError.noKing)
        #expect(ValidationError.noKing != ValidationError.multipleKings)
    }

    @Test("PositionValidationResult is Equatable")
    func resultEquatable() {
        let a = PositionValidationResult(errors: [.noKing])
        let b = PositionValidationResult(errors: [.noKing])
        #expect(a == b)
    }

    @Test("king on corner with no attackers is valid")
    func kingOnCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[5] = .attacker
        let result = PositionValidator.validate(Position(cells: cells))
        #expect(result.isValid)
    }
}
