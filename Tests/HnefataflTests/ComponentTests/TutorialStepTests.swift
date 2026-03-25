import Testing
@testable import Hnefatafl

@Suite("Tutorial Step Tests")
struct TutorialStepGuideTests {

    @Test("has 4 steps")
    func hasFourSteps() {
        #expect(TutorialStepGuide.steps().count == 4)
    }

    @Test("step numbers are sequential")
    func stepNumbersSequential() {
        let steps = TutorialStepGuide.steps()
        for (index, step) in steps.enumerated() {
            #expect(step.stepNumber == index + 1)
        }
    }

    @Test("titles are non-empty")
    func titlesNonEmpty() {
        for step in TutorialStepGuide.steps() {
            #expect(!step.title.isEmpty)
        }
    }

    @Test("king escape step highlights 4 corners")
    func kingEscapeHighlightsCorners() {
        let steps = TutorialStepGuide.steps()
        let lastStep = steps.last!
        #expect(lastStep.highlightSquares.count == 4)
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        for (i, sq) in lastStep.highlightSquares.enumerated() {
            #expect(sq.row == corners[i].0)
            #expect(sq.col == corners[i].1)
        }
    }

    @Test("total steps matches count")
    func totalStepsMatchesCount() {
        #expect(TutorialStepGuide.totalSteps == TutorialStepGuide.steps().count)
    }
}
