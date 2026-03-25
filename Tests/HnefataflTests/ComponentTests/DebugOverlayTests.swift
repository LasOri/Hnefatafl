import Testing
@testable import Hnefatafl

@Suite("Debug Overlay Tests")
struct DebugOverlayTests {

    @Test("initially hidden")
    func initiallyHidden() {
        let overlay = DebugOverlay()
        #expect(!overlay.isVisible)
    }

    @Test("toggle makes visible")
    func toggleVisible() {
        let overlay = DebugOverlay().toggle()
        #expect(overlay.isVisible)
    }

    @Test("double toggle hides")
    func doubleToggle() {
        let overlay = DebugOverlay().toggle().toggle()
        #expect(!overlay.isVisible)
    }

    @Test("shows position hash")
    func positionHash() {
        let info = DebugOverlay.info(for: GameState())
        #expect(info.keys.contains("position"))
    }

    @Test("shows move count")
    func moveCount() {
        let info = DebugOverlay.info(for: GameState())
        #expect(info.keys.contains("moveCount"))
    }

    @Test("shows current player")
    func currentPlayer() {
        let info = DebugOverlay.info(for: GameState())
        #expect(info.keys.contains("currentPlayer"))
    }

    @Test("shows piece counts")
    func pieceCounts() {
        let info = DebugOverlay.info(for: GameState())
        #expect(info.keys.contains("attackers"))
        #expect(info.keys.contains("defenders"))
    }

    @Test("DebugOverlay is Equatable")
    func equatable() {
        let a = DebugOverlay()
        let b = DebugOverlay()
        #expect(a == b)
    }
}
