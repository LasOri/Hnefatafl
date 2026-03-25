enum ValidationError: Equatable {
    case noKing
    case multipleKings
    case tooManyAttackers
    case tooManyDefenders
}

struct PositionValidationResult: Equatable {
    let errors: [ValidationError]
    var isValid: Bool { errors.isEmpty }
}

enum PositionValidator {
    static let maxAttackers = 24
    static let maxDefenders = 12

    static func validate(_ position: Position) -> PositionValidationResult {
        var errors: [ValidationError] = []

        var kingCount = 0
        var attackerCount = 0
        var defenderCount = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch position.pieceAt(row: row, col: col) {
                case .king: kingCount += 1
                case .attacker: attackerCount += 1
                case .defender: defenderCount += 1
                case nil: break
                }
            }
        }

        if kingCount == 0 { errors.append(.noKing) }
        if kingCount > 1 { errors.append(.multipleKings) }
        if attackerCount > maxAttackers { errors.append(.tooManyAttackers) }
        if defenderCount > maxDefenders { errors.append(.tooManyDefenders) }

        return PositionValidationResult(errors: errors)
    }
}
