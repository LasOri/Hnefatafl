struct EventWiring {
    static func actionForSquareClick(row: Int, col: Int, state: GameState) -> GameAction {
        if state.selectedSquare != nil {
            if let move = state.legalMovesForSelected.first(where: {
                $0.toRow == row && $0.toCol == col
            }) {
                return .makeMove(move)
            }
        }
        return .selectSquare(row: row, col: col)
    }

    static func actionForKey(_ key: String) -> GameAction? {
        switch key {
        case "ArrowUp": return .moveFocus(.up)
        case "ArrowDown": return .moveFocus(.down)
        case "ArrowLeft": return .moveFocus(.left)
        case "ArrowRight": return .moveFocus(.right)
        case "Escape": return .escape
        default: return nil
        }
    }

    static func actionForEnter(state: GameState) -> GameAction? {
        guard let focused = state.focusedSquare else { return nil }
        return .selectSquare(row: focused.row, col: focused.col)
    }

    static func actionForButton(_ action: String) -> GameAction? {
        switch action {
        case "new-game": return .newGame
        case "undo": return .undo
        case "toggle-ai": return .toggleAI
        default: return nil
        }
    }
}
