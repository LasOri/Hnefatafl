import Testing
@testable import Hnefatafl

@Suite("EventParser Tests")
struct EventParserTests {

    @Test("parses square click from row and col strings")
    func parsesSquareClick() {
        let result = EventParser.parseSquareClick(row: "3", col: "5")

        #expect(result?.row == 3)
        #expect(result?.col == 5)
    }

    @Test("returns nil for invalid row")
    func invalidRow() {
        let result = EventParser.parseSquareClick(row: "abc", col: "5")
        #expect(result == nil)
    }

    @Test("returns nil for nil row")
    func nilRow() {
        let result = EventParser.parseSquareClick(row: nil, col: "5")
        #expect(result == nil)
    }

    @Test("returns nil for nil col")
    func nilCol() {
        let result = EventParser.parseSquareClick(row: "3", col: nil)
        #expect(result == nil)
    }

    @Test("returns nil for negative values")
    func negativeValues() {
        let result = EventParser.parseSquareClick(row: "-1", col: "5")
        #expect(result == nil)
    }

    @Test("returns nil for out of bounds row")
    func outOfBoundsRow() {
        let result = EventParser.parseSquareClick(row: "11", col: "5")
        #expect(result == nil)
    }

    @Test("parseButtonAction returns action string")
    func parsesButtonAction() {
        let result = EventParser.parseButtonAction("new-game")
        #expect(result == "new-game")
    }

    @Test("parseButtonAction returns nil for nil")
    func nilButtonAction() {
        let result = EventParser.parseButtonAction(nil)
        #expect(result == nil)
    }

    @Test("parseButtonAction returns nil for empty string")
    func emptyButtonAction() {
        let result = EventParser.parseButtonAction("")
        #expect(result == nil)
    }

    @Test("parseButtonAction passes toggle-mute through")
    func parsesToggleMute() {
        let result = EventParser.parseButtonAction("toggle-mute")
        #expect(result == "toggle-mute")
    }

    @Test("toggle-mute round-trip through parser and wiring")
    func toggleMuteRoundTrip() {
        let parsed = EventParser.parseButtonAction("toggle-mute")
        let action = EventWiring.actionForButton(parsed!)
        #expect(action != nil)
        if case .toggleMute = action {} else {
            Issue.record("Expected .toggleMute")
        }
    }
}
