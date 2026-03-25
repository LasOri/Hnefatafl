import Testing
@testable import Hnefatafl

@Suite("Move Speed Tests")
struct MoveSpeedTests {

    @Test("short move is fast")
    func shortMoveIsFast() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let data = MoveSpeed.calculate(move: move)
        #expect(data.distance == 1)
        #expect(data.speedClass == .fast)
    }

    @Test("medium move is normal")
    func mediumMoveIsNormal() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 4)
        let data = MoveSpeed.calculate(move: move)
        #expect(data.distance == 4)
        #expect(data.speedClass == .normal)
    }

    @Test("long move is slow")
    func longMoveIsSlow() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 8)
        let data = MoveSpeed.calculate(move: move)
        #expect(data.distance == 8)
        #expect(data.speedClass == .slow)
    }

    @Test("duration increases with distance")
    func durationIncreasesWithDistance() {
        let short = MoveSpeed.calculate(move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1))
        let long = MoveSpeed.calculate(move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10))
        #expect(long.duration > short.duration)
    }

    @Test("boundary distance 2 is fast")
    func boundaryDistance2IsFast() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 2)
        let data = MoveSpeed.calculate(move: move)
        #expect(data.distance == 2)
        #expect(data.speedClass == .fast)
    }
}
