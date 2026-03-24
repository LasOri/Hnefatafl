struct HintEngine {
    static func bestMove(for game: Game, depth: Int = 2) -> Move? {
        guard game.status == .inProgress else { return nil }
        return EvaluationAI.pickMove(game: game, depth: depth)
    }
}
