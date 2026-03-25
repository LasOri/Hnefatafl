import Testing
@testable import Hnefatafl

@Suite("CaptureDisplay Tests")
struct CaptureDisplayTests {

    @Test("no captures at start")
    func noCapturesAtStart() {
        let position = Position.copenhagenStart()
        let captured = CaptureDisplay.capturedPieces(initialAttackers: 24, initialDefenders: 13, position: position)
        #expect(captured.isEmpty)
    }

    @Test("attacker captured shows in result")
    func attackerCaptured() {
        let position = Position.copenhagenStart()
        let captured = CaptureDisplay.capturedPieces(initialAttackers: 26, initialDefenders: 13, position: position)
        #expect(captured.count == 1)
        #expect(captured[0].piece == .attacker)
        #expect(captured[0].count == 2)
    }

    @Test("defender captured shows in result")
    func defenderCaptured() {
        let position = Position.copenhagenStart()
        let captured = CaptureDisplay.capturedPieces(initialAttackers: 24, initialDefenders: 15, position: position)
        #expect(captured.count == 1)
        #expect(captured[0].piece == .defender)
        #expect(captured[0].count == 2)
    }

    @Test("both sides captured")
    func bothCaptured() {
        let position = Position.copenhagenStart()
        let captured = CaptureDisplay.capturedPieces(initialAttackers: 25, initialDefenders: 14, position: position)
        #expect(captured.count == 2)
    }

    @Test("CapturedPieceInfo is Equatable")
    func equatable() {
        let a = CapturedPieceInfo(piece: .attacker, count: 3)
        let b = CapturedPieceInfo(piece: .attacker, count: 3)
        #expect(a == b)
    }
}
