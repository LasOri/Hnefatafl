import LINKER

func createGameStore() -> Store<GameState> {
    Store<GameState>(
        initialState: GameState(),
        reducer: { state, anyAction in
            if let gameAction = anyAction.as(GameAction.self) {
                return gameReducer(state: state, action: gameAction)
            }
            if let p2pAction = anyAction.as(P2PGameAction.self) {
                return p2pGameReducer(state: state, action: p2pAction)
            }
            return state
        }
    )
}

func createP2PGameStore() -> Store<GameState> {
    Store<GameState>(
        initialState: GameState(),
        reducer: { state, anyAction in
            if let gameAction = anyAction.as(GameAction.self) {
                return gameReducer(state: state, action: gameAction)
            }
            if let p2pAction = anyAction.as(P2PGameAction.self) {
                return p2pGameReducer(state: state, action: p2pAction)
            }
            return state
        },
        middlewares: [p2pGameMiddleware()]
    )
}
