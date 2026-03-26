struct MoveAnnotationEntry: Equatable {
    let moveIndex: Int
    let comment: String
    let scoreChange: Int
}

enum GameAnnotator {
    static func annotate(game: Game) -> [MoveAnnotationEntry] {
        let moves = game.moveHistory
        guard !moves.isEmpty else { return [] }

        var annotations: [MoveAnnotationEntry] = []
        var currentPos = Position.copenhagenStart()
        var currentPlayer: Player = .attacker

        for (index, move) in moves.enumerated() {
            let scoreBefore = EvaluationAI.evaluate(position: currentPos, for: currentPlayer)
            let newPos = currentPos.applyMove(move)
            let scoreAfter = EvaluationAI.evaluate(position: newPos, for: currentPlayer)
            let change = scoreAfter - scoreBefore

            let comment: String
            if change > 100 {
                comment = "Excellent move — significant advantage gained"
            } else if change > 0 {
                comment = "Good move — position improves"
            } else if change > -50 {
                comment = "Neutral move — position roughly equal"
            } else if change > -100 {
                comment = "Inaccuracy — slight disadvantage"
            } else {
                comment = "Mistake — significant advantage lost"
            }

            annotations.append(MoveAnnotationEntry(moveIndex: index, comment: comment, scoreChange: change))
            currentPos = newPos
            currentPlayer = currentPlayer == .attacker ? .defender : .attacker
        }

        return annotations
    }
}
