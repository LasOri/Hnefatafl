struct ScreenReaderState {
    static func describe(state: GameState) -> String {
        let turn = state.game.currentPlayer == .attacker ? "Attacker" : "Defender"
        let balance = PieceBalance.compute(position: state.game.position)
        return "\(turn)'s turn. Attackers: \(balance.attackers), Defenders: \(balance.defenders)."
    }

    static func describeStatus(_ status: GameStatus) -> String {
        switch status {
        case .inProgress: return "Game in progress"
        case .attackerWins: return "Attacker wins"
        case .defenderWins: return "Defender wins"
        case .draw: return "Game is a draw"
        }
    }

    static func describeMove(_ move: Move) -> String {
        let fromCol = String(UnicodeScalar(65 + move.fromCol)!)
        let fromRow = String(move.fromRow + 1)
        let toCol = String(UnicodeScalar(65 + move.toCol)!)
        let toRow = String(move.toRow + 1)
        return "\(fromCol)\(fromRow) to \(toCol)\(toRow)"
    }

    static func boardSummary(position: Position) -> String {
        let balance = PieceBalance.compute(position: position)
        return "11 by 11 board. \(balance.attackers) attackers, \(balance.defenders) defenders."
    }

    static func describeSquare(row: Int, col: Int, position: Position) -> String {
        let colLabel = String(UnicodeScalar(65 + col)!)
        let rowLabel = String(row + 1)
        let piece = position.pieceAt(row: row, col: col)
        let pieceDesc: String
        switch piece {
        case .attacker: pieceDesc = "Attacker"
        case .defender: pieceDesc = "Defender"
        case .king: pieceDesc = "King"
        case nil: pieceDesc = "Empty"
        }
        return "\(colLabel)\(rowLabel): \(pieceDesc)"
    }
}
