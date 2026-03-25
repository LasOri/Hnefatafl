import Testing
@testable import Hnefatafl

@Suite("Confirm Dialog Tests")
struct ConfirmDialogFactoryTests {

    @Test("new game dialog has correct title")
    func newGameTitle() {
        let dialog = ConfirmDialogFactory.newGame()
        #expect(dialog.title == "New Game")
    }

    @Test("new game dialog has confirm and cancel labels")
    func newGameLabels() {
        let dialog = ConfirmDialogFactory.newGame()
        #expect(dialog.confirmLabel == "New Game")
        #expect(dialog.cancelLabel == "Cancel")
    }

    @Test("resign dialog shows attacker name")
    func resignAttacker() {
        let dialog = ConfirmDialogFactory.resign(player: .attacker)
        #expect(dialog.message.contains("Attacker"))
    }

    @Test("resign dialog shows defender name")
    func resignDefender() {
        let dialog = ConfirmDialogFactory.resign(player: .defender)
        #expect(dialog.message.contains("Defender"))
    }

    @Test("dialog data equality")
    func dialogEquality() {
        let a = ConfirmDialogFactory.newGame()
        let b = ConfirmDialogFactory.newGame()
        #expect(a == b)
    }
}
