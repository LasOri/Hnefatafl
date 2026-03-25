struct MoveConfirmDialog: Equatable {
    let move: Move
    let isCapture: Bool
    let showUndo: Bool
    let timeoutSeconds: Double

    var confirmText: String {
        if isCapture {
            return "Confirm capture move?"
        }
        return "Confirm move?"
    }
}
