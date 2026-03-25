import Testing
@testable import Hnefatafl

@Suite("Replay Controls Tests")
struct ReplayControlsStructTests {

    @Test("canGoForward when not at end")
    func canGoForwardNotAtEnd() {
        let controls = ReplayControls(currentMoveIndex: 3, totalMoves: 10, isPlaying: false)
        #expect(controls.canGoForward == true)
    }

    @Test("cannot go forward when at end")
    func cannotGoForwardAtEnd() {
        let controls = ReplayControls(currentMoveIndex: 10, totalMoves: 10, isPlaying: false)
        #expect(controls.canGoForward == false)
    }

    @Test("canGoBack when not at start")
    func canGoBackNotAtStart() {
        let controls = ReplayControls(currentMoveIndex: 5, totalMoves: 10, isPlaying: true)
        #expect(controls.canGoBack == true)
    }

    @Test("cannot go back when at start")
    func cannotGoBackAtStart() {
        let controls = ReplayControls(currentMoveIndex: 0, totalMoves: 10, isPlaying: false)
        #expect(controls.canGoBack == false)
    }

    @Test("progress at start is zero")
    func progressAtStartZero() {
        let controls = ReplayControls(currentMoveIndex: 0, totalMoves: 10, isPlaying: false)
        #expect(controls.progress == 0.0)
    }

    @Test("progress at end is one")
    func progressAtEndOne() {
        let controls = ReplayControls(currentMoveIndex: 10, totalMoves: 10, isPlaying: false)
        #expect(controls.progress == 1.0)
    }

    @Test("progress with zero total moves is zero")
    func progressZeroTotalMoves() {
        let controls = ReplayControls(currentMoveIndex: 0, totalMoves: 0, isPlaying: false)
        #expect(controls.progress == 0.0)
    }
}
