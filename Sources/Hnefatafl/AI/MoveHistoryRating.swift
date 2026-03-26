struct MoveHistoryRatingResult: Equatable {
    let score: Int
    let moveCount: Int
    let label: String
}

enum MoveHistoryRating {
    static func rate(game: Game) -> MoveHistoryRatingResult {
        let moves = game.moveHistory
        guard !moves.isEmpty else {
            return MoveHistoryRatingResult(score: 0, moveCount: 0, label: "No moves")
        }

        var totalScore = 0
        var currentPos = game.positionHistory.first ?? Position.copenhagenStart()
        var currentPlayer: Player = .attacker

        for move in moves {
            let scoreBefore = EvaluationAI.evaluate(position: currentPos, for: currentPlayer)
            let newPos = currentPos.applyMove(move)
            let scoreAfter = EvaluationAI.evaluate(position: newPos, for: currentPlayer)
            let change = scoreAfter - scoreBefore

            if change > 0 {
                totalScore += 1
            } else if change < -50 {
                totalScore -= 1
            }

            currentPos = newPos
            currentPlayer = currentPlayer == .attacker ? .defender : .attacker
        }

        let normalized = max(-100, min(100, totalScore * 10))

        let label: String
        if normalized > 30 {
            label = "Strong"
        } else if normalized > 0 {
            label = "Good"
        } else if normalized > -30 {
            label = "Average"
        } else {
            label = "Weak"
        }

        return MoveHistoryRatingResult(score: normalized, moveCount: moves.count, label: label)
    }
}
