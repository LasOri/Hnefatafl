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
        case "toggle-mute": return .toggleMute
        case "cycle-difficulty": return .cycleDifficulty
        case "flip-board": return .flipBoard
        case "toggle-rules": return .toggleRules
        case "enter-replay": return .enterReplay
        case "exit-replay": return .exitReplay
        case "replay-forward": return .replayForward
        case "replay-back": return .replayBack
        case "request-hint": return .requestHint
        case "toggle-coordinates": return .toggleCoordinates
        case "cycle-personality": return .cyclePersonality
        case "cycle-variant": return .cycleVariant
        case "toggle-p2p": return .toggleP2P
        default: return nil
        }
    }

    static func p2pActionForButton(_ action: String, state: GameState) -> P2PGameAction? {
        switch action {
        case "p2p-host":
            return .hostGame(variant: state.selectedVariant)
        case "p2p-join":
            return .joinGame(peerId: "")
        case "p2p-leave":
            return .leaveGame
        default:
            return nil
        }
    }
}
