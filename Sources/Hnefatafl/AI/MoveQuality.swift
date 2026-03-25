enum MoveQualityRating: String, CaseIterable, Equatable {
    case blunder
    case inaccuracy
    case good
    case excellent
    case brilliant
}

enum MoveQualityAnalyzer {
    static func rate(evalBefore: Int, evalAfter: Int) -> MoveQualityRating {
        let delta = evalAfter - evalBefore
        if delta <= -200 { return .blunder }
        if delta <= -50 { return .inaccuracy }
        if delta < 50 { return .good }
        if delta < 200 { return .excellent }
        return .brilliant
    }
}
