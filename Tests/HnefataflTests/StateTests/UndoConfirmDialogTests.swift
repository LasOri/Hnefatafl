import Testing
@testable import Hnefatafl

@Suite("Undo Confirm Dialog Tests")
struct UndoConfirmDialogTests {

    @Test("ConfirmDialog starts hidden")
    func startsHidden() {
        let dialog = ConfirmDialog()
        #expect(!dialog.isVisible)
    }

    @Test("ConfirmDialog show sets visible")
    func showSetsVisible() {
        let dialog = ConfirmDialog().show(message: "Undo 5 moves?")
        #expect(dialog.isVisible)
        #expect(dialog.message == "Undo 5 moves?")
    }

    @Test("ConfirmDialog dismiss hides")
    func dismissHides() {
        let dialog = ConfirmDialog().show(message: "test").dismiss()
        #expect(!dialog.isVisible)
        #expect(dialog.message == nil)
    }

    @Test("ConfirmDialog confirm returns action")
    func confirmAction() {
        let dialog = ConfirmDialog().show(message: "test")
        #expect(dialog.isVisible)
        let dismissed = dialog.confirm()
        #expect(!dismissed.isVisible)
    }

    @Test("ConfirmDialog is Equatable")
    func equatable() {
        let a = ConfirmDialog()
        let b = ConfirmDialog()
        #expect(a == b)
    }

    @Test("UndoGuard message includes move count")
    func undoGuardMessage() {
        let msg = UndoGuard.confirmMessage(moveCount: 15)
        #expect(msg.contains("15"))
    }

    @Test("UndoGuard message for captures")
    func captureMessage() {
        let msg = UndoGuard.confirmMessage(moveCount: 15, captureCount: 3)
        #expect(msg.contains("3"))
    }

    @Test("ConfirmDialog preserves message through show")
    func preserveMessage() {
        let dialog = ConfirmDialog().show(message: "Are you sure?")
        #expect(dialog.message == "Are you sure?")
    }
}
