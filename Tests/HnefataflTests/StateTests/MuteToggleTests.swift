import Testing
@testable import Hnefatafl
import LINKER
import LINKERTesting

@Suite("Mute Toggle Tests")
struct MuteToggleTests {

    @Test("muted is false by default")
    func mutedFalseByDefault() {
        let state = GameState()
        #expect(state.muted == false)
    }

    @Test("toggleMute flips muted to true")
    func toggleMuteFlipsToTrue() {
        let state = GameState()
        let toggled = gameReducer(state: state, action: GameAction.toggleMute)
        #expect(toggled.muted == true)
    }

    @Test("toggleMute flips muted back to false")
    func toggleMuteFlipsBack() {
        let state = GameState()
        let on = gameReducer(state: state, action: GameAction.toggleMute)
        let off = gameReducer(state: on, action: GameAction.toggleMute)
        #expect(off.muted == false)
    }

    @Test("muted preserved through makeMove")
    func mutedPreservedThroughMakeMove() {
        let state = GameState()
        let muted = gameReducer(state: state, action: GameAction.toggleMute)
        let move = muted.game.position.allLegalMoves(for: muted.game.currentPlayer).first!
        let afterMove = gameReducer(state: muted, action: GameAction.makeMove(move))
        #expect(afterMove.muted == true)
    }

    @Test("muted preserved through selectSquare")
    func mutedPreservedThroughSelectSquare() {
        let state = GameState()
        let muted = gameReducer(state: state, action: GameAction.toggleMute)
        let afterSelect = gameReducer(state: muted, action: GameAction.selectSquare(row: 0, col: 3))
        #expect(afterSelect.muted == true)
    }

    @Test("muted preserved through undo")
    func mutedPreservedThroughUndo() {
        let state = GameState()
        let muted = gameReducer(state: state, action: GameAction.toggleMute)
        let move = muted.game.position.allLegalMoves(for: muted.game.currentPlayer).first!
        let afterMove = gameReducer(state: muted, action: GameAction.makeMove(move))
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)
        #expect(afterUndo.muted == true)
    }

    @Test("muted preserved through newGame")
    func mutedPreservedThroughNewGame() {
        let state = GameState()
        let muted = gameReducer(state: state, action: GameAction.toggleMute)
        let afterNew = gameReducer(state: muted, action: GameAction.newGame)
        #expect(afterNew.muted == true)
    }

    @Test("EventWiring maps toggle-mute to toggleMute")
    func eventWiringMapsToggleMute() {
        let action = EventWiring.actionForButton("toggle-mute")
        #expect(action != nil)
        if case .toggleMute = action {} else {
            Issue.record("Expected .toggleMute")
        }
    }

    @Test("AppComponent renders mute button with Mute label when unmuted")
    func muteButtonShowsMuteWhenUnmuted() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let muteBtn = rendered.findAll(tag: "button").first(where: { $0.attr("data-action") == "toggle-mute" })
        #expect(muteBtn != nil)
        #expect(muteBtn?.text == "Mute")
    }

    @Test("AppComponent renders mute button with Unmute label when muted")
    func muteButtonShowsUnmuteWhenMuted() {
        var state = GameState()
        state = gameReducer(state: state, action: GameAction.toggleMute)
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let muteBtn = rendered.findAll(tag: "button").first(where: { $0.attr("data-action") == "toggle-mute" })
        #expect(muteBtn != nil)
        #expect(muteBtn?.text == "Unmute")
    }
}
