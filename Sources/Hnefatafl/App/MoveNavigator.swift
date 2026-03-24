struct MoveNavigator {
    static func stepCount(game: Game) -> Int {
        game.positionHistory.count
    }

    static func position(at step: Int, in game: Game) -> Position {
        let clamped = max(0, min(step, game.positionHistory.count - 1))
        return game.positionHistory[clamped]
    }

    static func activePlayer(at step: Int, in game: Game) -> Player {
        step % 2 == 0 ? .attacker : .defender
    }

    static func move(at step: Int, in game: Game) -> Move? {
        guard step >= 0 && step < game.moveHistory.count else { return nil }
        return game.moveHistory[step]
    }
}
