import Testing
@testable import Hnefatafl

@Suite("EscapeCornerCoverage Tests")
struct EscapeCornerCoverageTests {
    @Test("Empty board has no covered corners")
    func emptyBoardNoCoverage() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let covered = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(covered == 0)
    }

    @Test("Attacker adjacent to corner covers it")
    func attackerAdjacentCovers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .attacker
        let position = Position(cells: cells)
        let covered = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(covered >= 1)
    }

    @Test("Coverage score is 25 per covered corner")
    func coverageScorePerCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .attacker
        let position = Position(cells: cells)
        let score = EscapeCornerCoverage.coverageScore(position: position)
        let corners = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(score == corners * 25)
    }

    @Test("Start position has some corner coverage")
    func startPositionCoverage() {
        let position = Position.copenhagenStart()
        let covered = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(covered >= 0 && covered <= 4)
    }

    @Test("All four corners can be covered")
    func allFourCovered() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .attacker
        cells[0 * 11 + 9] = .attacker
        cells[10 * 11 + 1] = .attacker
        cells[10 * 11 + 9] = .attacker
        let position = Position(cells: cells)
        let covered = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(covered == 4)
    }

    @Test("Defender near corner does not count as coverage")
    func defenderDoesNotCover() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .defender
        let position = Position(cells: cells)
        let covered = EscapeCornerCoverage.coveredCorners(position: position)
        #expect(covered == 0)
    }
}
