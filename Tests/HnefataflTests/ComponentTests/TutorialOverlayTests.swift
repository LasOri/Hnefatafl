import Testing
@testable import Hnefatafl

@Suite("Tutorial Overlay Tests")
struct TutorialOverlayTests {

    @Test("TutorialStep has title and description")
    func stepProperties() {
        let step = TutorialStep(title: "Welcome", description: "Learn to play", highlightSquares: [])
        #expect(step.title == "Welcome")
        #expect(step.description == "Learn to play")
    }

    @Test("Tutorial has ordered steps")
    func orderedSteps() {
        let tutorial = Tutorial.beginnerTutorial()
        #expect(tutorial.steps.count >= 3)
    }

    @Test("Tutorial starts at step 0")
    func startsAtZero() {
        let state = TutorialState()
        #expect(state.currentStep == 0)
    }

    @Test("advance increments step")
    func advanceStep() {
        let state = TutorialState().advance(totalSteps: 5)
        #expect(state.currentStep == 1)
    }

    @Test("advance clamps at last step")
    func clampAtEnd() {
        let state = TutorialState(currentStep: 4).advance(totalSteps: 5)
        #expect(state.currentStep == 4)
    }

    @Test("goBack decrements step")
    func goBack() {
        let state = TutorialState(currentStep: 2).goBack()
        #expect(state.currentStep == 1)
    }

    @Test("goBack clamps at zero")
    func clampAtStart() {
        let state = TutorialState(currentStep: 0).goBack()
        #expect(state.currentStep == 0)
    }

    @Test("isComplete returns true at last step")
    func isComplete() {
        let state = TutorialState(currentStep: 4)
        #expect(state.isComplete(totalSteps: 5))
    }

    @Test("beginner tutorial covers movement")
    func coversMovement() {
        let tutorial = Tutorial.beginnerTutorial()
        let hasMovement = tutorial.steps.contains { $0.title.lowercased().contains("move") }
        #expect(hasMovement)
    }

    @Test("highlight squares for step")
    func highlightSquares() {
        let step = TutorialStep(title: "Test", description: "Test", highlightSquares: [(row: 5, col: 5)])
        #expect(step.highlightSquares.count == 1)
    }
}
