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
