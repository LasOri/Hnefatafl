import Testing
@testable import Hnefatafl

@Suite("Piece Animation Tests")
struct PieceAnimationTests {

    @Test("MoveAnimation computes duration from distance")
    func durationFromDistance() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let duration = MoveAnimation.duration(for: move)
        #expect(duration > 0)
    }

    @Test("longer moves have longer duration")
    func longerMoveLongerDuration() {
        let short = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 2)
        let long = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 8)
        #expect(MoveAnimation.duration(for: long) > MoveAnimation.duration(for: short))
    }

    @Test("MoveAnimation has min duration")
    func minDuration() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        #expect(MoveAnimation.duration(for: move) >= MoveAnimation.minDuration)
    }

    @Test("MoveAnimation has max duration")
    func maxDuration() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 10, toCol: 0)
        #expect(MoveAnimation.duration(for: move) <= MoveAnimation.maxDuration)
    }

    @Test("CaptureAnimation burst has keyframes")
    func burstKeyframes() {
        let frames = CaptureAnimation.burstKeyframes()
        #expect(frames.count >= 3)
    }

    @Test("CaptureAnimation burst starts at scale 1")
    func burstStartScale() {
        let frames = CaptureAnimation.burstKeyframes()
        #expect(frames[0].scale == 1.0)
    }

    @Test("CaptureAnimation burst ends at scale 0")
    func burstEndScale() {
        let frames = CaptureAnimation.burstKeyframes()
        #expect(frames.last!.scale == 0.0)
    }

    @Test("CaptureAnimation burst has peak scale > 1")
    func burstPeakScale() {
        let frames = CaptureAnimation.burstKeyframes()
        let peak = frames.max(by: { $0.scale < $1.scale })!
        #expect(peak.scale > 1.0)
    }

    @Test("Keyframe has time and scale")
    func keyframeProperties() {
        let frame = AnimationKeyframe(time: 0.5, scale: 1.2, opacity: 0.8)
        #expect(frame.time == 0.5)
        #expect(frame.scale == 1.2)
        #expect(frame.opacity == 0.8)
    }

    @Test("MoveAnimation css class name")
    func cssClassName() {
        #expect(!MoveAnimation.cssClassName.isEmpty)
    }
}
