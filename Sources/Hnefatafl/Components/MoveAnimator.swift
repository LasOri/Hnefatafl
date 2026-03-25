struct AnimationData: Equatable {
    let fromRow: Int
    let fromCol: Int
    let toRow: Int
    let toCol: Int
    let durationMs: Int
    let easing: AnimationEasing
}

enum AnimationEasing: String, Equatable {
    case linear
    case easeInOut = "ease-in-out"
    case easeOut = "ease-out"
}

enum MoveAnimator {
    static func animate(move: Move, captured: [(Int, Int)] = []) -> [AnimationData] {
        var anims: [AnimationData] = []
        let dist = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
        let duration = 100 + dist * 50
        anims.append(AnimationData(fromRow: move.fromRow, fromCol: move.fromCol, toRow: move.toRow, toCol: move.toCol, durationMs: duration, easing: .easeInOut))
        for (row, col) in captured {
            anims.append(AnimationData(fromRow: row, fromCol: col, toRow: row, toCol: col, durationMs: 200, easing: .easeOut))
        }
        return anims
    }
}
