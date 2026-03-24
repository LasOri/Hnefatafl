import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Rules Modal Tests")
struct RulesModalTests {

    @Test("showRules defaults to false")
    func defaultsToFalse() {
        let state = GameState()
        #expect(state.showRules == false)
    }

    @Test("toggleRules flips showRules")
    func togglesShowRules() {
        let state = GameState()
        let shown = gameReducer(state: state, action: GameAction.toggleRules)
        #expect(shown.showRules == true)
        let hidden = gameReducer(state: shown, action: GameAction.toggleRules)
        #expect(hidden.showRules == false)
    }

    @Test("EventWiring maps toggle-rules action")
    func eventWiringMaps() {
        let action = EventWiring.actionForButton("toggle-rules")
        #expect(action != nil)
        if case .toggleRules = action {} else {
            Issue.record("Expected .toggleRules")
        }
    }

    @Test("RulesContent contains game objective")
    func containsObjective() {
        let nodes = RulesContent.render()
        let rendered = render(nodes)
        let text = rendered.findByText("escape")
        #expect(text != nil)
    }

    @Test("AppComponent renders rules button")
    func rendersRulesButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let btn = rendered.findAll(tag: "button").first(where: { $0.attr("data-action") == "toggle-rules" })
        #expect(btn != nil)
    }

    @Test("AppComponent renders rules overlay when showRules is true")
    func rendersOverlay() {
        var state = gameReducer(state: GameState(), action: GameAction.toggleRules)
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let overlay = rendered.findAll(tag: "div").first(where: { $0.className?.contains("rules-overlay") == true })
        #expect(overlay != nil)
    }
}
