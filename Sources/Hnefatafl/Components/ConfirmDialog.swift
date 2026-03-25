struct ConfirmDialogData: Equatable {
    let title: String
    let message: String
    let confirmLabel: String
    let cancelLabel: String
}

enum ConfirmDialogFactory {
    static func newGame() -> ConfirmDialogData {
        ConfirmDialogData(
            title: "New Game",
            message: "Start a new game? Current progress will be lost.",
            confirmLabel: "New Game",
            cancelLabel: "Cancel"
        )
    }

    static func resign(player: Player) -> ConfirmDialogData {
        let name = player == .attacker ? "Attacker" : "Defender"
        return ConfirmDialogData(
            title: "Resign",
            message: "\(name), are you sure you want to resign?",
            confirmLabel: "Resign",
            cancelLabel: "Cancel"
        )
    }
}
