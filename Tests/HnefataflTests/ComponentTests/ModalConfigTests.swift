import Testing
@testable import Hnefatafl

@Suite("Modal Config Tests")
struct ModalConfigTests {

    @Test("resign confirmation is destructive")
    func resignIsDestructive() {
        let config = ModalConfig.resignConfirmation()
        #expect(config.isDestructive)
    }

    @Test("new game confirmation is not destructive")
    func newGameNotDestructive() {
        let config = ModalConfig.newGameConfirmation()
        #expect(!config.isDestructive)
    }

    @Test("resign has correct title")
    func resignTitle() {
        let config = ModalConfig.resignConfirmation()
        #expect(config.title == "Resign Game")
    }

    @Test("new game has correct title")
    func newGameTitle() {
        let config = ModalConfig.newGameConfirmation()
        #expect(config.title == "New Game")
    }

    @Test("resign has cancel label")
    func resignHasCancel() {
        let config = ModalConfig.resignConfirmation()
        #expect(config.cancelLabel == "Cancel")
    }

    @Test("configs are equatable")
    func equatable() {
        let a = ModalConfig.resignConfirmation()
        let b = ModalConfig.resignConfirmation()
        #expect(a == b)
    }

    @Test("different configs are not equal")
    func notEqual() {
        let resign = ModalConfig.resignConfirmation()
        let newGame = ModalConfig.newGameConfirmation()
        #expect(resign != newGame)
    }
}
