struct DragDropManager {
    static func startDrag(row: Int, col: Int, state: GameState) -> GameAction? {
        guard let piece = state.game.position.pieceAt(row: row, col: col) else {
            return nil
        }
        let belongsToCurrentPlayer: Bool
        switch state.game.currentPlayer {
        case .attacker: belongsToCurrentPlayer = piece.isAttackerSide
        case .defender: belongsToCurrentPlayer = piece.isDefenderSide
        }
        guard belongsToCurrentPlayer else { return nil }
        return .selectSquare(row: row, col: col)
    }

    static func canDrop(row: Int, col: Int, state: GameState) -> Bool {
        state.legalMovesForSelected.contains { $0.toRow == row && $0.toCol == col }
    }

    static func completeDrop(row: Int, col: Int, state: GameState) -> GameAction? {
        guard state.selectedSquare != nil else { return nil }
        guard let move = state.legalMovesForSelected.first(where: {
            $0.toRow == row && $0.toCol == col
        }) else { return nil }
        return .makeMove(move)
    }
}
