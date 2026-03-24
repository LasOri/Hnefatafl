struct ReplayController {
    static func totalSteps(in game: Game) -> Int {
        game.positionHistory.count
    }

    static func position(at step: Int, in game: Game) -> Position {
        let clamped = max(0, min(step, game.positionHistory.count - 1))
        return game.positionHistory[clamped]
    }
}
