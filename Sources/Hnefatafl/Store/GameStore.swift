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
    let linkerP2P = P2PMiddleware()

    return Store<GameState>(
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
        middlewares: [
            // LINKER P2P middleware handles IrohBridge lifecycle (spawn, connect, send)
            { action, getState, dispatch, next in
                linkerP2P.handle(action: action, getState: { nil }, dispatch: dispatch, next: next)
            },
            // Hnefatafl P2P game middleware translates P2PActions ↔ P2PGameActions
            p2pGameMiddleware()
        ]
    )
}
