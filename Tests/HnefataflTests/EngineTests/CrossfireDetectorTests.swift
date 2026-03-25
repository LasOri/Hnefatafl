import Testing
@testable import Hnefatafl

@Suite("Crossfire Detector Tests")
struct CrossfireDetectorTests {

    @Test("empty board has no crossfire squares")
    func emptyBoardNone() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(CrossfireDetector.crossfireCount(position: pos) == 0)
    }

    @Test("two attackers in same row create crossfire between them")
    func twoAttackersSameRow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 2] = .attacker
        cells[5 * 11 + 8] = .attacker
        let pos = Position(cells: cells)
        let squares = CrossfireDetector.crossfireSquares(position: pos)
        let hasMiddle = squares.contains(where: { $0.row == 5 && $0.col > 2 && $0.col < 8 })
        #expect(hasMiddle)
    }

    @Test("single attacker creates no crossfire")
    func singleAttackerNone() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(CrossfireDetector.crossfireCount(position: pos) == 0)
    }

    @Test("crossfireCount matches crossfireSquares length")
    func countMatchesSquares() {
        let pos = Position.copenhagenStart()
        let squares = CrossfireDetector.crossfireSquares(position: pos)
        let count = CrossfireDetector.crossfireCount(position: pos)
        #expect(count == squares.count)
    }

    @Test("occupied square is not a crossfire square")
    func occupiedNotCrossfire() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 7] = .attacker
        let pos = Position(cells: cells)
        let squares = CrossfireDetector.crossfireSquares(position: pos)
        let hasOccupied = squares.contains(where: { $0.row == 5 && $0.col == 5 })
        #expect(!hasOccupied)
    }

    @Test("start position has crossfire squares")
    func startPositionHasCrossfire() {
        let pos = Position.copenhagenStart()
        #expect(CrossfireDetector.crossfireCount(position: pos) > 0)
    }
}
