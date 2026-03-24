import LINKER

func selectGameStatus(store: Store<GameState>) -> Computed<GameStatus> {
    Computed { store.getState().game.status }
}

func selectSelectedSquare(store: Store<GameState>) -> Computed<(row: Int, col: Int)?> {
    Computed { store.getState().selectedSquare }
}

func selectLegalMoves(store: Store<GameState>) -> Computed<[Move]> {
    Computed { store.getState().legalMovesForSelected }
}

func selectAttackersCaptured(store: Store<GameState>) -> Computed<Int> {
    Computed { store.getState().attackersCaptured }
}

func selectDefendersCaptured(store: Store<GameState>) -> Computed<Int> {
    Computed { store.getState().defendersCaptured }
}

func selectAIMode(store: Store<GameState>) -> Computed<AIMode> {
    Computed { store.getState().aiMode }
}

func selectMuted(store: Store<GameState>) -> Computed<Bool> {
    Computed { store.getState().muted }
}

func selectLastMove(store: Store<GameState>) -> Computed<Move?> {
    Computed { store.getState().lastMove }
}

func selectFocusedSquare(store: Store<GameState>) -> Computed<(row: Int, col: Int)?> {
    Computed { store.getState().focusedSquare }
}
