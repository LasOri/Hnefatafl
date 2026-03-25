import Testing
@testable import Hnefatafl

@Suite("MovePreviewData Tests")
struct MovePreviewDataTests {
    @Test("Capture count matches captured positions")
    func captureCountMatchesPositions() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 3)
        let data = MovePreviewData(move: move, isCapture: true, capturedPositions: [(0, 1), (0, 2)])
        #expect(data.captureCount == 2)
    }

    @Test("No captures gives zero capture count")
    func noCapturesZero() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 7)
        let data = MovePreviewData(move: move, isCapture: false, capturedPositions: [])
        #expect(data.captureCount == 0)
    }

    @Test("isCapture flag is preserved")
    func isCaptureFlagPreserved() {
        let move = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 5)
        let data = MovePreviewData(move: move, isCapture: true, capturedPositions: [(1, 3)])
        #expect(data.isCapture == true)
    }

    @Test("Move is preserved")
    func movePreserved() {
        let move = Move(fromRow: 3, fromCol: 4, toRow: 7, toCol: 4)
        let data = MovePreviewData(move: move, isCapture: false, capturedPositions: [])
        #expect(data.move == move)
    }

    @Test("Equatable works for identical data")
    func equatableIdentical() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let a = MovePreviewData(move: move, isCapture: true, capturedPositions: [(0, 2)])
        let b = MovePreviewData(move: move, isCapture: true, capturedPositions: [(0, 2)])
        #expect(a == b)
    }

    @Test("Equatable detects different captured positions")
    func equatableDifferent() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let a = MovePreviewData(move: move, isCapture: true, capturedPositions: [(0, 2)])
        let b = MovePreviewData(move: move, isCapture: true, capturedPositions: [(0, 3)])
        #expect(a != b)
    }
}
