struct TutorialStep {
    let title: String
    let description: String
    let highlightSquares: [(row: Int, col: Int)]
}

struct TutorialState: Equatable {
    let currentStep: Int

    init(currentStep: Int = 0) {
        self.currentStep = currentStep
    }

    func advance(totalSteps: Int) -> TutorialState {
        let next = min(currentStep + 1, totalSteps - 1)
        return TutorialState(currentStep: next)
    }

    func goBack() -> TutorialState {
        TutorialState(currentStep: max(currentStep - 1, 0))
    }

    func isComplete(totalSteps: Int) -> Bool {
        currentStep >= totalSteps - 1
    }
}

struct Tutorial {
    let steps: [TutorialStep]

    static func beginnerTutorial() -> Tutorial {
        Tutorial(steps: [
            TutorialStep(
                title: "Welcome to Hnefatafl",
                description: "A Viking strategy game. Defenders protect the King, attackers try to capture him.",
                highlightSquares: []
            ),
            TutorialStep(
                title: "How to Move",
                description: "All pieces move like rooks in chess — any number of squares in a straight line.",
                highlightSquares: [(row: 5, col: 5)]
            ),
            TutorialStep(
                title: "Capturing",
                description: "Sandwich an enemy piece between two of your pieces to capture it.",
                highlightSquares: []
            ),
            TutorialStep(
                title: "The King",
                description: "The King must reach any corner to win. Attackers must surround the King on all four sides.",
                highlightSquares: [(row: 0, col: 0), (row: 0, col: 10), (row: 10, col: 0), (row: 10, col: 10)]
            ),
            TutorialStep(
                title: "Special Squares",
                description: "The center throne and corners are hostile — only the King may stop on them.",
                highlightSquares: [(row: 5, col: 5)]
            ),
        ])
    }
}
