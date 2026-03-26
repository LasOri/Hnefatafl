struct PhaseScoreResult: Equatable {
    let phase: String
    let value: Int
}

enum GamePhaseScore {
    static func evaluate(position: Position, for player: Player) -> PhaseScoreResult {
        var totalPieces = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) != nil {
                    totalPieces += 1
                }
            }
        }

        let phase: String
        if totalPieces >= 30 {
            phase = "opening"
        } else if totalPieces >= 15 {
            phase = "midgame"
        } else {
            phase = "endgame"
        }

        let baseScore = EvaluationAI.evaluate(position: position, for: player)

        let modifier: Int
        switch phase {
        case "opening": modifier = 0
        case "midgame": modifier = baseScore / 10
        case "endgame": modifier = baseScore / 5
        default: modifier = 0
        }

        return PhaseScoreResult(phase: phase, value: baseScore + modifier)
    }
}
