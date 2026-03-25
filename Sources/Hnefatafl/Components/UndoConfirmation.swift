struct UndoConfirmData: Equatable {
    let movesBack: Int
    let message: String
    let canUndo: Bool
}

enum UndoConfirmation {
    static func data(moveCount: Int) -> UndoConfirmData {
        let canUndo = moveCount > 0
        let message = canUndo ? "Undo last move?" : "No moves to undo"
        return UndoConfirmData(movesBack: 1, message: message, canUndo: canUndo)
    }
}
