import LINKER

func createGameStore() -> Store<GameState> {
    Store<GameState>(
        initialState: GameState(),
        reducer: { state, anyAction in
            guard let action = anyAction.as(GameAction.self) else { return state }
            return gameReducer(state: state, action: action)
        }
    )
}
