import LINKER

func selectGameStatus(store: Store<GameState>) -> Computed<GameStatus> {
    Computed {
        let state = store.getState()
        return state.game.status
    }
}
