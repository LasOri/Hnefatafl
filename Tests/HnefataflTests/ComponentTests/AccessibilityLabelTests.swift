import Testing
@testable import Hnefatafl

@Suite("Accessibility Label Tests")
struct AccessibilityLabelTests {

    @Test("square label for empty square")
    func emptySquare() {
        let label = AccessibilityLabels.squareLabel(row: 0, col: 0, piece: nil)
        #expect(label.contains("A1"))
        #expect(label.contains("empty"))
    }

    @Test("square label for attacker")
    func attackerLabel() {
        let label = AccessibilityLabels.squareLabel(row: 3, col: 4, piece: .attacker)
        #expect(label.contains("attacker"))
        #expect(label.contains("E4"))
    }

    @Test("square label for king")
    func kingLabel() {
        let label = AccessibilityLabels.squareLabel(row: 5, col: 5, piece: .king)
        #expect(label.contains("king"))
        #expect(label.contains("F6"))
    }

    @Test("square label for defender")
    func defenderLabel() {
        let label = AccessibilityLabels.squareLabel(row: 0, col: 10, piece: .defender)
        #expect(label.contains("defender"))
    }

    @Test("button label for new game")
    func newGameButton() {
        let label = AccessibilityLabels.buttonLabel(action: "new-game")
        #expect(label.contains("New"))
    }

    @Test("button label for undo")
    func undoButton() {
        let label = AccessibilityLabels.buttonLabel(action: "undo")
        #expect(label.contains("Undo"))
    }

    @Test("status label for player turn")
    func turnLabel() {
        let label = AccessibilityLabels.turnLabel(player: .attacker)
        #expect(label.contains("Attacker"))
    }

    @Test("status label for defender turn")
    func defenderTurn() {
        let label = AccessibilityLabels.turnLabel(player: .defender)
        #expect(label.contains("Defender"))
    }

    @Test("game over label")
    func gameOverLabel() {
        let label = AccessibilityLabels.gameOverLabel(status: .attackerWins)
        #expect(label.contains("win"))
    }

    @Test("unknown button returns generic label")
    func unknownButton() {
        let label = AccessibilityLabels.buttonLabel(action: "unknown-action")
        #expect(!label.isEmpty)
    }
}
