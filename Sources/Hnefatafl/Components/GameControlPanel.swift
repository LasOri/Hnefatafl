struct GameControlPanel: Equatable {
    let canUndo: Bool
    let canRedo: Bool
    let canResign: Bool
    let isPaused: Bool

    static func forGame(moveCount: Int, isGameOver: Bool) -> GameControlPanel {
        GameControlPanel(
            canUndo: moveCount > 0 && !isGameOver,
            canRedo: false,
            canResign: !isGameOver && moveCount > 0,
            isPaused: false
        )
    }
}
