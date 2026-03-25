import Testing
@testable import Hnefatafl

@Suite("ReplayControls Tests")
struct ReplayControlsTests {
    @Test("Creates replay state with total steps")
    func createReplayState() {
        let state = ReplayState(totalSteps: 10)
        #expect(state.totalSteps == 10)
        #expect(state.currentStep == 0)
    }

    @Test("Is at start initially")
    func isAtStartInitially() {
        let state = ReplayState(totalSteps: 5)
        #expect(state.isAtStart == true)
        #expect(state.isAtEnd == false)
    }

    @Test("Advances to next step")
    func nextStep() {
        var state = ReplayState(totalSteps: 5)
        state.next()
        #expect(state.currentStep == 1)
        #expect(state.isAtStart == false)
    }

    @Test("Goes to previous step")
    func previousStep() {
        var state = ReplayState(totalSteps: 5)
        state.next()
        state.next()
        state.previous()
        #expect(state.currentStep == 1)
    }

    @Test("Goes to start")
    func goToStart() {
        var state = ReplayState(totalSteps: 5)
        state.next()
        state.next()
        state.goToStart()
        #expect(state.currentStep == 0)
        #expect(state.isAtStart == true)
    }

    @Test("Goes to end")
    func goToEnd() {
        var state = ReplayState(totalSteps: 5)
        state.goToEnd()
        #expect(state.currentStep == 5)
        #expect(state.isAtEnd == true)
    }

    @Test("Next does not exceed total steps")
    func nextDoesNotExceed() {
        var state = ReplayState(totalSteps: 3)
        state.next()
        state.next()
        state.next()
        state.next()
        #expect(state.currentStep == 3)
    }

    @Test("Previous does not go below zero")
    func previousDoesNotGoBelowZero() {
        var state = ReplayState(totalSteps: 5)
        state.previous()
        #expect(state.currentStep == 0)
    }
}
