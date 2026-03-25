import Testing
@testable import Hnefatafl

@Suite("Capture Animation Data Tests")
struct CaptureAnimationDataTests {

    @Test("attacker capture is not king capture")
    func attackerCaptureNotKing() {
        let anim = CaptureAnimationData(capturedRow: 3, capturedCol: 5, capturedPiece: .attacker, duration: 0.3)
        #expect(!anim.isKingCapture)
    }

    @Test("defender capture is not king capture")
    func defenderCaptureNotKing() {
        let anim = CaptureAnimationData(capturedRow: 3, capturedCol: 5, capturedPiece: .defender, duration: 0.3)
        #expect(!anim.isKingCapture)
    }

    @Test("king capture is king capture")
    func kingCaptureIsKing() {
        let anim = CaptureAnimationData(capturedRow: 5, capturedCol: 5, capturedPiece: .king, duration: 0.5)
        #expect(anim.isKingCapture)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = CaptureAnimationData(capturedRow: 1, capturedCol: 2, capturedPiece: .attacker, duration: 0.3)
        let b = CaptureAnimationData(capturedRow: 1, capturedCol: 2, capturedPiece: .attacker, duration: 0.3)
        #expect(a == b)
    }

    @Test("different pieces are not equal")
    func differentPiecesNotEqual() {
        let a = CaptureAnimationData(capturedRow: 1, capturedCol: 2, capturedPiece: .attacker, duration: 0.3)
        let b = CaptureAnimationData(capturedRow: 1, capturedCol: 2, capturedPiece: .defender, duration: 0.3)
        #expect(a != b)
    }

    @Test("duration is stored correctly")
    func durationStored() {
        let anim = CaptureAnimationData(capturedRow: 0, capturedCol: 0, capturedPiece: .attacker, duration: 0.75)
        #expect(anim.duration == 0.75)
    }
}
