import Testing
@testable import Hnefatafl

@Suite("Game Overlay Tests")
struct GameOverlayTests {

    @Test("pause overlay has correct type")
    func pauseOverlayType() {
        let overlay = GameOverlay.pauseOverlay()
        #expect(overlay.type == .pause)
        #expect(overlay.isVisible)
        #expect(overlay.title == "Game Paused")
    }

    @Test("attacker wins overlay")
    func attackerWinsOverlay() {
        let overlay = GameOverlay.gameOverOverlay(result: .attackerWins)
        #expect(overlay.type == .gameOver)
        #expect(overlay.title == "Attackers Win!")
    }

    @Test("defender wins overlay")
    func defenderWinsOverlay() {
        let overlay = GameOverlay.gameOverOverlay(result: .defenderWins)
        #expect(overlay.title == "Defenders Win!")
    }

    @Test("draw overlay")
    func drawOverlay() {
        let overlay = GameOverlay.gameOverOverlay(result: .draw)
        #expect(overlay.title == "Draw")
    }

    @Test("in progress overlay shows generic title")
    func inProgressOverlay() {
        let overlay = GameOverlay.gameOverOverlay(result: .inProgress)
        #expect(overlay.title == "Game Over")
    }

    @Test("overlay type raw values")
    func overlayTypeRawValues() {
        #expect(OverlayType.pause.rawValue == "pause")
        #expect(OverlayType.gameOver.rawValue == "gameOver")
        #expect(OverlayType.help.rawValue == "help")
        #expect(OverlayType.settings.rawValue == "settings")
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameOverlay.pauseOverlay()
        let b = GameOverlay(type: .pause, isVisible: true, title: "Game Paused")
        #expect(a == b)
    }
}
