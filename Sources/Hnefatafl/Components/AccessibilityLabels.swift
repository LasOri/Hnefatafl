import LINKER

struct AccessibilityLabels {
    static func squareLabel(row: Int, col: Int, piece: Piece?) -> String {
        let coord = "\(Position.columnLetter(col))\(row + 1)"
        let pieceDesc: String
        switch piece {
        case .attacker: pieceDesc = "attacker"
        case .defender: pieceDesc = "defender"
        case .king: pieceDesc = "king"
        case nil: pieceDesc = "empty"
        }
        return "\(coord) \(pieceDesc)"
    }

    static func buttonLabel(action: String) -> String {
        switch action {
        case "new-game": return "New Game"
        case "undo": return "Undo Move"
        case "toggle-ai": return "Toggle AI"
        case "toggle-mute": return "Toggle Sound"
        case "cycle-difficulty": return "Change Difficulty"
        case "cycle-personality": return "Change AI Style"
        case "cycle-variant": return "Change Variant"
        case "flip-board": return "Flip Board"
        case "toggle-rules": return "Show Rules"
        case "request-hint": return "Get Hint"
        case "toggle-coordinates": return "Toggle Coordinates"
        default: return capitalizeWords(action.replacingAll("-", with: " "))
        }
    }

    static func turnLabel(player: Player) -> String {
        player == .attacker ? "Attacker's turn" : "Defender's turn"
    }

    static func gameOverLabel(status: GameStatus) -> String {
        switch status {
        case .attackerWins: return "Attackers win!"
        case .defenderWins: return "Defenders win!"
        case .draw: return "Game drawn"
        case .inProgress: return "Game in progress"
        }
    }
}

private func capitalizeWords(_ text: String) -> String {
    var result = ""
    var capitalizeNext = true
    for ch in text {
        if ch == " " {
            result.append(ch)
            capitalizeNext = true
        } else if capitalizeNext {
            result.append(ch.uppercased().first ?? ch)
            capitalizeNext = false
        } else {
            result.append(ch)
        }
    }
    return result
}