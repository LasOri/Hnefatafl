import Testing
@testable import Hnefatafl

@Suite("Move Timestamp Tests")
struct MoveTimestampTests {

    @Test("formatted time for zero seconds")
    func zeroSeconds() {
        let ts = MoveTimestamp(moveIndex: 0, elapsedSeconds: 0)
        #expect(ts.formattedTime == "00:00")
    }

    @Test("formatted time for 90 seconds")
    func ninetySeconds() {
        let ts = MoveTimestamp(moveIndex: 5, elapsedSeconds: 90)
        #expect(ts.formattedTime == "01:30")
    }

    @Test("formatted time for exactly one minute")
    func oneMinute() {
        let ts = MoveTimestamp(moveIndex: 1, elapsedSeconds: 60)
        #expect(ts.formattedTime == "01:00")
    }

    @Test("move index is stored correctly")
    func moveIndexStored() {
        let ts = MoveTimestamp(moveIndex: 42, elapsedSeconds: 100)
        #expect(ts.moveIndex == 42)
    }

    @Test("equatable compares both fields")
    func equatable() {
        let a = MoveTimestamp(moveIndex: 1, elapsedSeconds: 30)
        let b = MoveTimestamp(moveIndex: 1, elapsedSeconds: 30)
        #expect(a == b)
    }

    @Test("different timestamps are not equal")
    func notEqual() {
        let a = MoveTimestamp(moveIndex: 1, elapsedSeconds: 30)
        let b = MoveTimestamp(moveIndex: 1, elapsedSeconds: 31)
        #expect(a != b)
    }

    @Test("large elapsed time formats correctly")
    func largeTime() {
        let ts = MoveTimestamp(moveIndex: 100, elapsedSeconds: 3661)
        #expect(ts.formattedTime == "61:01")
    }
}
