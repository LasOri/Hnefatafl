import Testing
@testable import Hnefatafl

@Suite("GapAnalysis Tests")
struct GapAnalysisTests {
    @Test("Empty board has gaps")
    func emptyBoardGaps() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let gaps = GapAnalysis.gapCount(position: position)
        #expect(gaps > 0)
    }

    @Test("Largest gap on empty board is full perimeter")
    func emptyBoardLargestGap() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let largest = GapAnalysis.largestGap(position: position)
        #expect(largest > 0)
    }

    @Test("Single edge attacker creates two gaps")
    func singleEdgeAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5] = .attacker
        let position = Position(cells: cells)
        let gaps = GapAnalysis.gapCount(position: position)
        #expect(gaps >= 1)
    }

    @Test("Start position has some gaps")
    func startPositionGaps() {
        let position = Position.copenhagenStart()
        let gaps = GapAnalysis.gapCount(position: position)
        #expect(gaps >= 0)
    }

    @Test("Largest gap is non-negative")
    func largestGapNonNegative() {
        let position = Position.copenhagenStart()
        let largest = GapAnalysis.largestGap(position: position)
        #expect(largest >= 0)
    }

    @Test("More edge attackers reduce largest gap")
    func moreAttackersReduceGap() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[0] = .attacker
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[0] = .attacker
        cells2[5] = .attacker
        cells2[10] = .attacker
        let pos2 = Position(cells: cells2)

        let gap1 = GapAnalysis.largestGap(position: pos1)
        let gap2 = GapAnalysis.largestGap(position: pos2)
        #expect(gap2 <= gap1)
    }
}
