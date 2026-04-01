enum AIMode: Equatable {
    case humanVsHuman
    case humanVsAI(humanSide: Player)
}

struct AIGameLoop {
    static func aiMove(game: Game, mode: AIMode, difficulty: AIDifficulty = .medium) -> Move? {
        EnhancedAIGameLoop.selectMove(game: game, mode: mode, difficulty: difficulty)
    }
}
