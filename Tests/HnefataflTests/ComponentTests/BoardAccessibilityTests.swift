import Testing
@testable import Hnefatafl

@Suite("Board Accessibility Tests")
struct BoardAccessibilityTests {

    @Test("empty regular square label")
    func emptyRegularSquare() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let label = BoardAccessibility.squareLabel(row: 3, col: 3, position: position)
        #expect(label == "D8, empty")
    }

    @Test("throne square label")
    func throneSquareLabel() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let label = BoardAccessibility.squareLabel(row: 5, col: 5, position: position)
        #expect(label == "F6, throne, empty")
    }

    @Test("corner square label")
    func cornerSquareLabel() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let label = BoardAccessibility.squareLabel(row: 0, col: 0, position: position)
        #expect(label == "A11, corner, empty")
    }

    @Test("attacker piece label")
    func attackerPieceLabel() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let label = BoardAccessibility.squareLabel(row: 3, col: 3, position: position)
        #expect(label == "D8, attacker")
    }

    @Test("king piece label")
    func kingPieceLabel() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let label = BoardAccessibility.squareLabel(row: 5, col: 5, position: position)
        #expect(label == "F6, king")
    }

    @Test("board summary")
    func boardSummary() {
        let position = Position.copenhagenStart()
        let summary = BoardAccessibility.boardSummary(position: position)
        #expect(summary.contains("attackers"))
        #expect(summary.contains("defenders"))
        #expect(summary.starts(with: "Hnefatafl board"))
    }
}
