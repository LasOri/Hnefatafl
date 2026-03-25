import Testing
@testable import Hnefatafl

@Suite("Loading Indicator Tests")
struct LoadingIndicatorTests {

    @Test("thinking state is loading with AI message")
    func thinkingState() {
        let state = LoadingIndicator.thinking()
        #expect(state.isLoading == true)
        #expect(state.message == "AI thinking...")
        #expect(state.progress == nil)
    }

    @Test("loading state is loading")
    func loadingState() {
        let state = LoadingIndicator.loading()
        #expect(state.isLoading == true)
        #expect(state.message == "Loading...")
    }

    @Test("progress state has value")
    func progressState() {
        let state = LoadingIndicator.progress(0.5)
        #expect(state.isLoading == true)
        #expect(state.progress == 0.5)
    }

    @Test("done state is not loading")
    func doneState() {
        let state = LoadingIndicator.done()
        #expect(state.isLoading == false)
        #expect(state.message == "")
    }

    @Test("loading state equality")
    func loadingEquality() {
        let a = LoadingIndicator.thinking()
        let b = LoadingIndicator.thinking()
        #expect(a == b)
    }
}
