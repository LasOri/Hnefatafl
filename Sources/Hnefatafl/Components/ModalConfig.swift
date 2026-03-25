struct ModalConfig: Equatable {
    var title: String
    var message: String
    var confirmLabel: String
    var cancelLabel: String
    var isDestructive: Bool

    static func resignConfirmation() -> ModalConfig {
        ModalConfig(
            title: "Resign Game",
            message: "Are you sure you want to resign? This cannot be undone.",
            confirmLabel: "Resign",
            cancelLabel: "Cancel",
            isDestructive: true
        )
    }

    static func newGameConfirmation() -> ModalConfig {
        ModalConfig(
            title: "New Game",
            message: "Start a new game? Current progress will be lost.",
            confirmLabel: "New Game",
            cancelLabel: "Cancel",
            isDestructive: false
        )
    }
}
