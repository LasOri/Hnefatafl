struct AnnotatedMove: Equatable {
    let move: Move
    let annotation: String
    let quality: MoveQuality
}

enum MoveQuality: String, Equatable {
    case brilliant = "!!"
    case good = "!"
    case interesting = "!?"
    case dubious = "?!"
    case mistake = "?"
    case blunder = "??"
    case normal = ""
}

enum MoveAnnotation {
    static func annotate(move: Move, position: Position, player: Player, evalBefore: Int, evalAfter: Int) -> AnnotatedMove {
        let diff = evalAfter - evalBefore
        let quality: MoveQuality
        if diff > 200 { quality = .brilliant }
        else if diff > 100 { quality = .good }
        else if diff > 50 { quality = .interesting }
        else if diff > -50 { quality = .normal }
        else if diff > -100 { quality = .dubious }
        else if diff > -200 { quality = .mistake }
        else { quality = .blunder }

        return AnnotatedMove(move: move, annotation: quality.rawValue, quality: quality)
    }
}
