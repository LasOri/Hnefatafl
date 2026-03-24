struct UndoGuard {
    static let moveCountThreshold = 10
    static let captureCountThreshold = 1
    static let confirmationMessage = "Are you sure you want to undo? This will revert a significant game action."

    static func needsConfirmation(state: GameState) -> Bool {
        guard !state.undoStack.isEmpty else { return false }

        let totalCaptures = state.captureHistory.filter { $0 }.count
        if totalCaptures >= captureCountThreshold {
            return true
        }

        if state.captureHistory.count >= moveCountThreshold {
            return true
        }

        return false
    }
}
