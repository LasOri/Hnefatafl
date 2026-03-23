enum AIMode: Equatable {
    case humanVsHuman
    case humanVsAI(humanSide: Player)
}

struct AIGameLoop {
    static func aiMove(game: Game, mode: AIMode) -> Move? {
        guard game.status == .inProgress else { return nil }

        switch mode {
        case .humanVsHuman:
            return nil
        case .humanVsAI(let humanSide):
            guard game.currentPlayer != humanSide else { return nil }
            return EvaluationAI.pickMove(game: game)
        }
    }
}
