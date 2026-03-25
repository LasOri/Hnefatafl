import Testing
@testable import Hnefatafl

@Suite("TurnBadge Tests")
struct TurnBadgeTests {

    @Test("display text for attacker")
    func displayTextAttacker() {
        let badge = TurnBadge(turnNumber: 5, player: .attacker, isAITurn: false)
        #expect(badge.displayText == "Turn 5 - Attacker")
    }

    @Test("display text for defender")
    func displayTextDefender() {
        let badge = TurnBadge(turnNumber: 3, player: .defender, isAITurn: true)
        #expect(badge.displayText == "Turn 3 - Defender")
    }

    @Test("short text format")
    func shortText() {
        let badge = TurnBadge(turnNumber: 12, player: .attacker, isAITurn: false)
        #expect(badge.shortText == "T12")
    }

    @Test("equatable conformance")
    func equatable() {
        let a = TurnBadge(turnNumber: 1, player: .attacker, isAITurn: false)
        let b = TurnBadge(turnNumber: 1, player: .attacker, isAITurn: false)
        #expect(a == b)
    }

    @Test("inequal when different turn")
    func inequalTurn() {
        let a = TurnBadge(turnNumber: 1, player: .attacker, isAITurn: false)
        let b = TurnBadge(turnNumber: 2, player: .attacker, isAITurn: false)
        #expect(a != b)
    }

    @Test("isAITurn flag stored correctly")
    func aiTurnFlag() {
        let badge = TurnBadge(turnNumber: 1, player: .defender, isAITurn: true)
        #expect(badge.isAITurn == true)
    }
}
