struct ReplayState: Equatable {
    let totalSteps: Int
    private(set) var currentStep: Int = 0

    var isAtStart: Bool {
        currentStep == 0
    }

    var isAtEnd: Bool {
        currentStep == totalSteps
    }

    mutating func next() {
        if currentStep < totalSteps {
            currentStep += 1
        }
    }

    mutating func previous() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }

    mutating func goToStart() {
        currentStep = 0
    }

    mutating func goToEnd() {
        currentStep = totalSteps
    }
}

struct ReplayControls: Equatable {
    let currentMoveIndex: Int
    let totalMoves: Int
    let isPlaying: Bool

    var canGoForward: Bool {
        currentMoveIndex < totalMoves
    }

    var canGoBack: Bool {
        currentMoveIndex > 0
    }

    var progress: Double {
        guard totalMoves > 0 else { return 0.0 }
        return Double(currentMoveIndex) / Double(totalMoves)
    }
}
