struct ValidationResult: Equatable {
    let isValid: Bool
    let message: String
}

struct MoveValidationFeedback {
    static func validate(from: (Int, Int), to: (Int, Int), piece: Piece?, position: Position) -> ValidationResult? {
        guard piece != nil else {
            return ValidationResult(isValid: false, message: "No piece at selected square")
        }

        if from.0 == to.0 && from.1 == to.1 {
            return ValidationResult(isValid: false, message: "Cannot move to the same square")
        }

        if from.0 != to.0 && from.1 != to.1 {
            return ValidationResult(isValid: false, message: "Pieces can only move in straight lines")
        }

        let throne = (5, 5)
        if to == throne && piece != .king {
            return ValidationResult(isValid: false, message: "Only the king may occupy the throne")
        }

        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        if corners.contains(where: { $0 == to }) && piece != .king {
            return ValidationResult(isValid: false, message: "Only the king may move to corner squares")
        }

        return nil
    }
}
