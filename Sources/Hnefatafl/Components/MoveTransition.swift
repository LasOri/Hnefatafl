struct MoveTransition: Equatable {
    let fromRow: Int
    let fromCol: Int
    let toRow: Int
    let toCol: Int
    let progress: Double

    var isComplete: Bool {
        progress >= 1.0
    }

    var currentRow: Double {
        Double(fromRow) + Double(toRow - fromRow) * progress
    }

    var currentCol: Double {
        Double(fromCol) + Double(toCol - fromCol) * progress
    }
}
