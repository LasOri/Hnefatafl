enum MovePreference: Equatable {
    case moveA
    case moveB
    case equal
}

struct MoveComparisonResult: Equatable {
    let scoreA: Int
    let scoreB: Int
    let preferred: MovePreference
    let explanation: String
}

enum MoveComparator {
    static func compare(moveA: Move, moveB: Move, in game: Game) -> MoveComparisonResult {
        let posA = game.position.applyMove(moveA)
        let posB = game.position.applyMove(moveB)
        let scoreA = EvaluationAI.evaluate(position: posA, for: game.currentPlayer)
        let scoreB = EvaluationAI.evaluate(position: posB, for: game.currentPlayer)

        let preferred: MovePreference
        let explanation: String

        if scoreA > scoreB {
            preferred = .moveA
            explanation = "Move A scores \(scoreA) vs \(scoreB) — better by \(scoreA - scoreB) points"
        } else if scoreB > scoreA {
            preferred = .moveB
            explanation = "Move B scores \(scoreB) vs \(scoreA) — better by \(scoreB - scoreA) points"
        } else {
            preferred = .equal
            explanation = "Both moves score equally at \(scoreA)"
        }

        return MoveComparisonResult(scoreA: scoreA, scoreB: scoreB, preferred: preferred, explanation: explanation)
    }
}
