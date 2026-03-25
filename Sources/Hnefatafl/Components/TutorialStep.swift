struct TutorialStepData: Equatable {
    let stepNumber: Int
    let title: String
    let instruction: String
    let highlightSquares: [(row: Int, col: Int)]

    static func == (lhs: TutorialStepData, rhs: TutorialStepData) -> Bool {
        lhs.stepNumber == rhs.stepNumber
            && lhs.title == rhs.title
            && lhs.instruction == rhs.instruction
            && lhs.highlightSquares.count == rhs.highlightSquares.count
            && zip(lhs.highlightSquares, rhs.highlightSquares).allSatisfy { $0.row == $1.row && $0.col == $1.col }
    }
}

enum TutorialStepGuide {
    static func steps() -> [TutorialStepData] {
        [
            TutorialStepData(stepNumber: 1, title: "Select a Piece", instruction: "Tap any attacker piece to select it", highlightSquares: []),
            TutorialStepData(stepNumber: 2, title: "Move the Piece", instruction: "Tap a highlighted square to move", highlightSquares: []),
            TutorialStepData(stepNumber: 3, title: "Capture", instruction: "Sandwich an enemy between two of your pieces", highlightSquares: []),
            TutorialStepData(stepNumber: 4, title: "King Escape", instruction: "The king must reach a corner", highlightSquares: [(0, 0), (0, 10), (10, 0), (10, 10)]),
        ]
    }

    static var totalSteps: Int { steps().count }
}
