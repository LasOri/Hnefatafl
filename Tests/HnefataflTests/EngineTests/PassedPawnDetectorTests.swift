import Testing
@testable import Hnefatafl

@Suite("Passed Pawn Detector Tests")
struct PassedPawnDetectorTests {

    @Test("empty board has no passed defenders")
    func emptyBoardNoPassed() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let passed = PassedPawnDetector.passedDefenders(position: position)
        #expect(passed.isEmpty)
    }

    @Test("defender on same row as corner with clear path is passed")
    func defenderOnCornerRow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let passed = PassedPawnDetector.passedDefenders(position: position)
        #expect(passed.count == 1)
        #expect(passed[0].row == 0 && passed[0].col == 5)
    }

    @Test("defender blocked by attacker is not passed")
    func defenderBlockedByAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .defender
        cells[0 * 11 + 3] = .attacker
        cells[0 * 11 + 7] = .attacker
        cells[3 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let passed = PassedPawnDetector.passedDefenders(position: position)
        #expect(passed.isEmpty)
    }

    @Test("king counts as passed pawn candidate")
    func kingCountsAsPassed() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .king
        let position = Position(cells: cells)
        let passed = PassedPawnDetector.passedDefenders(position: position)
        #expect(passed.count == 1)
    }

    @Test("attacker is not detected as passed")
    func attackerNotDetected() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let passed = PassedPawnDetector.passedDefenders(position: position)
        #expect(passed.isEmpty)
    }
}
