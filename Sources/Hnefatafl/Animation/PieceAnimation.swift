struct AnimationKeyframe: Equatable {
    let time: Double
    let scale: Double
    let opacity: Double
}

struct MoveAnimation {
    static let minDuration: Double = 0.15
    static let maxDuration: Double = 0.5
    static let cssClassName = "piece-move"

    static func duration(for move: Move) -> Double {
        let distance = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
        let raw = 0.1 + Double(distance) * 0.04
        return min(max(raw, minDuration), maxDuration)
    }
}

struct CaptureAnimation {
    static func burstKeyframes() -> [AnimationKeyframe] {
        [
            AnimationKeyframe(time: 0.0, scale: 1.0, opacity: 1.0),
            AnimationKeyframe(time: 0.3, scale: 1.4, opacity: 0.8),
            AnimationKeyframe(time: 0.6, scale: 1.2, opacity: 0.4),
            AnimationKeyframe(time: 1.0, scale: 0.0, opacity: 0.0),
        ]
    }
}
