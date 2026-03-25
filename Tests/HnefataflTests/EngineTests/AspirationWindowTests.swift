import Testing
@testable import Hnefatafl

@Suite("Aspiration Window Tests")
struct AspirationWindowTests {

    @Test("initial window centered on previous score")
    func initialWindow() {
        let window = AspirationWindow(previousScore: 100)
        #expect(window.alpha < 100)
        #expect(window.beta > 100)
    }

    @Test("default window size is 50")
    func defaultSize() {
        #expect(AspirationWindow.defaultSize == 50)
    }

    @Test("widen increases window")
    func widenIncreases() {
        let window = AspirationWindow(previousScore: 100)
        let wider = window.widen()
        #expect(wider.alpha < window.alpha)
        #expect(wider.beta > window.beta)
    }

    @Test("failed low widens alpha")
    func failedLow() {
        let window = AspirationWindow(previousScore: 100)
        let result = window.handleFailLow()
        #expect(result.alpha < window.alpha)
        #expect(result.beta == window.beta)
    }

    @Test("failed high widens beta")
    func failedHigh() {
        let window = AspirationWindow(previousScore: 100)
        let result = window.handleFailHigh()
        #expect(result.beta > window.beta)
        #expect(result.alpha == window.alpha)
    }

    @Test("score within window returns true")
    func scoreWithin() {
        let window = AspirationWindow(previousScore: 100)
        #expect(window.contains(score: 100))
    }

    @Test("score outside window returns false")
    func scoreOutside() {
        let window = AspirationWindow(previousScore: 100, size: 10)
        #expect(!window.contains(score: 200))
    }

    @Test("AspirationWindow is Equatable")
    func equatable() {
        let a = AspirationWindow(previousScore: 100)
        let b = AspirationWindow(previousScore: 100)
        #expect(a == b)
    }
}
