struct GameRewindPoint: Equatable {
    let position: Position
    let currentPlayer: Player
    let moveIndex: Int

    static func from(game: Game) -> GameRewindPoint {
        GameRewindPoint(
            position: game.position,
            currentPlayer: game.currentPlayer,
            moveIndex: game.moveHistory.count
        )
    }
}
