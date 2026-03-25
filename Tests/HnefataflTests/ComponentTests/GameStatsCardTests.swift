import Testing
@testable import Hnefatafl

@Suite("GameStatsCard Tests")
struct GameStatsCardTests {
    @Test("Properties store correct values")
    func properties() {
        let card = GameStatsCard(totalMoves: 42, captureCount: 7, averageMoveTime: 3.5)
        #expect(card.totalMoves == 42)
        #expect(card.captureCount == 7)
        #expect(card.averageMoveTime == 3.5)
    }

    @Test("Move rate text with valid time")
    func moveRateValidTime() {
        let card = GameStatsCard(totalMoves: 10, captureCount: 2, averageMoveTime: 6.0)
        #expect(card.moveRateText == "10.0 moves/min")
    }

    @Test("Move rate text with zero time returns N/A")
    func moveRateZeroTime() {
        let card = GameStatsCard(totalMoves: 10, captureCount: 2, averageMoveTime: 0.0)
        #expect(card.moveRateText == "N/A")
    }

    @Test("Move rate text with negative time returns N/A")
    func moveRateNegativeTime() {
        let card = GameStatsCard(totalMoves: 10, captureCount: 2, averageMoveTime: -1.0)
        #expect(card.moveRateText == "N/A")
    }

    @Test("Cards are equatable")
    func equatable() {
        let a = GameStatsCard(totalMoves: 10, captureCount: 3, averageMoveTime: 2.0)
        let b = GameStatsCard(totalMoves: 10, captureCount: 3, averageMoveTime: 2.0)
        #expect(a == b)
    }

    @Test("Different cards are not equal")
    func notEqual() {
        let a = GameStatsCard(totalMoves: 10, captureCount: 3, averageMoveTime: 2.0)
        let b = GameStatsCard(totalMoves: 11, captureCount: 3, averageMoveTime: 2.0)
        #expect(a != b)
    }
}
