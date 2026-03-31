import Testing
@testable import Hnefatafl

@Suite("Move Timer Tests")
struct MoveTimerTests {

    @Test("initial elapsed is zero")
    func initialZero() {
        let timer = MoveTimer()
        #expect(timer.elapsed == 0)
    }

    @Test("record adds time")
    func recordAdds() {
        var timer = MoveTimer()
        timer.record(seconds: 5.0)
        #expect(timer.totalTime == 5.0)
    }

    @Test("average time computed")
    func averageTime() {
        var timer = MoveTimer()
        timer.record(seconds: 4.0)
        timer.record(seconds: 6.0)
        #expect(timer.averageTime == 5.0)
    }

    @Test("move count tracks records")
    func moveCount() {
        var timer = MoveTimer()
        timer.record(seconds: 1.0)
        timer.record(seconds: 2.0)
        timer.record(seconds: 3.0)
        #expect(timer.moveCount == 3)
    }

    @Test("longest move tracked")
    func longestMove() {
        var timer = MoveTimer()
        timer.record(seconds: 1.0)
        timer.record(seconds: 5.0)
        timer.record(seconds: 3.0)
        #expect(timer.longestMove == 5.0)
    }

    @Test("empty timer has zero average")
    func emptyAverage() {
        let timer = MoveTimer()
        #expect(timer.averageTime == 0)
    }

    @Test("MoveTimer is Equatable")
    func equatable() {
        let a = MoveTimer()
        let b = MoveTimer()
        #expect(a == b)
    }
}
