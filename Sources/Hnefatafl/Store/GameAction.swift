import LINKER

enum FocusDirection {
    case up, down, left, right
}

enum GameAction: Action {
    case selectSquare(row: Int, col: Int)
    case makeMove(Move)
    case newGame
    case undo
    case moveFocus(FocusDirection)
    case escape
    case toggleAI
    case toggleMute
    case cycleDifficulty
    case flipBoard
    case toggleRules
}
