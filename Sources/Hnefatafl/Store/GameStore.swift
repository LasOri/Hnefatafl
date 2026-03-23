import LINKER

func createGameStore() -> Store<GameState> {
    Store<GameState>(
        initialState: GameState(),
        reducer: gameReducer
    )
}
