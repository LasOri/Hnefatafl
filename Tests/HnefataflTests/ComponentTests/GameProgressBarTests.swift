import Testing
@testable import Hnefatafl

@Suite("Game Progress Bar Tests")
struct GameProgressBarTests {

    @Test("progress at start is zero")
    func progressAtStart() {
        let bar = GameProgressBar(currentMove: 0, estimatedTotalMoves: 100)
        #expect(bar.progress == 0.0)
    }

    @Test("progress at halfway is 0.5")
    func progressHalfway() {
        let bar = GameProgressBar(currentMove: 50, estimatedTotalMoves: 100)
        #expect(bar.progress == 0.5)
    }

    @Test("progress capped at 1.0")
    func progressCapped() {
        let bar = GameProgressBar(currentMove: 150, estimatedTotalMoves: 100)
        #expect(bar.progress == 1.0)
    }

    @Test("zero estimated total returns zero progress")
    func zeroEstimatedTotal() {
        let bar = GameProgressBar(currentMove: 10, estimatedTotalMoves: 0)
        #expect(bar.progress == 0.0)
    }

    @Test("isNearEnd false at start")
    func notNearEndAtStart() {
        let bar = GameProgressBar(currentMove: 10, estimatedTotalMoves: 100)
        #expect(!bar.isNearEnd)
    }

    @Test("isNearEnd true past 75 percent")
    func nearEndPast75() {
        let bar = GameProgressBar(currentMove: 80, estimatedTotalMoves: 100)
        #expect(bar.isNearEnd)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameProgressBar(currentMove: 10, estimatedTotalMoves: 50)
        let b = GameProgressBar(currentMove: 10, estimatedTotalMoves: 50)
        #expect(a == b)
    }
}
