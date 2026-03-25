import Testing
@testable import Hnefatafl

@Suite("MoveConfirmDialog Tests")
struct MoveConfirmDialogTests {

    @Test("confirm text for capture move")
    func captureConfirmText() {
        let dialog = MoveConfirmDialog(
            move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5),
            isCapture: true,
            showUndo: true,
            timeoutSeconds: 3.0
        )
        #expect(dialog.confirmText == "Confirm capture move?")
    }

    @Test("confirm text for non-capture move")
    func nonCaptureConfirmText() {
        let dialog = MoveConfirmDialog(
            move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5),
            isCapture: false,
            showUndo: false,
            timeoutSeconds: 5.0
        )
        #expect(dialog.confirmText == "Confirm move?")
    }

    @Test("showUndo flag stored")
    func showUndoFlag() {
        let dialog = MoveConfirmDialog(
            move: Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 5),
            isCapture: false,
            showUndo: true,
            timeoutSeconds: 2.0
        )
        #expect(dialog.showUndo == true)
    }

    @Test("timeout stored correctly")
    func timeoutStored() {
        let dialog = MoveConfirmDialog(
            move: Move(fromRow: 0, fromCol: 0, toRow: 5, toCol: 0),
            isCapture: false,
            showUndo: false,
            timeoutSeconds: 7.5
        )
        #expect(dialog.timeoutSeconds == 7.5)
    }

    @Test("equatable conformance")
    func equatable() {
        let m = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let a = MoveConfirmDialog(move: m, isCapture: true, showUndo: true, timeoutSeconds: 3.0)
        let b = MoveConfirmDialog(move: m, isCapture: true, showUndo: true, timeoutSeconds: 3.0)
        #expect(a == b)
    }

    @Test("inequal when different capture flag")
    func inequalCapture() {
        let m = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let a = MoveConfirmDialog(move: m, isCapture: true, showUndo: true, timeoutSeconds: 3.0)
        let b = MoveConfirmDialog(move: m, isCapture: false, showUndo: true, timeoutSeconds: 3.0)
        #expect(a != b)
    }
}
