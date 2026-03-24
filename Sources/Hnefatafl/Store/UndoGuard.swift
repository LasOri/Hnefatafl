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

    static func confirmMessage(moveCount: Int, captureCount: Int = 0) -> String {
        var msg = "Undo \(moveCount) moves?"
        if captureCount > 0 {
            msg += " This will restore \(captureCount) captured pieces."
        }
        return msg
    }
}

struct ConfirmDialog: Equatable {
    let isVisible: Bool
    let message: String?

    init() {
        isVisible = false
        message = nil
    }

    private init(isVisible: Bool, message: String?) {
        self.isVisible = isVisible
        self.message = message
    }

    func show(message: String) -> ConfirmDialog {
        ConfirmDialog(isVisible: true, message: message)
    }

    func dismiss() -> ConfirmDialog {
        ConfirmDialog(isVisible: false, message: nil)
    }

    func confirm() -> ConfirmDialog {
        ConfirmDialog(isVisible: false, message: nil)
    }
}
