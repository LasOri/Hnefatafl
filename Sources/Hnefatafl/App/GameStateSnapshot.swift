import LINKER

struct GameStateSnapshot: Equatable {
    let timestamp: Double
    let moveNumber: Int
    let positionData: String
    let currentPlayer: Player

    static func capture(from state: GameState, at time: Double? = nil) -> GameStateSnapshot {
        GameStateSnapshot(
            timestamp: time ?? currentTimestamp(),
            moveNumber: state.game.moveHistory.count,
            positionData: PositionSerializer.serialize(position: state.game.position),
            currentPlayer: state.game.currentPlayer
        )
    }
}
