import Testing
@testable import Hnefatafl

@Suite("TargetSquareAnalysis Tests")
struct TargetSquareAnalysisTests {
    @Test("Top targets returns requested count or fewer")
    func topTargetsCount() {
        let position = Position.copenhagenStart()
        let targets = TargetSquareAnalysis.topTargets(position: position, player: .attacker, count: 3)
        #expect(targets.count <= 3)
    }

    @Test("Top targets are empty squares")
    func topTargetsAreEmpty() {
        let position = Position.copenhagenStart()
        let targets = TargetSquareAnalysis.topTargets(position: position, player: .attacker, count: 5)
        for target in targets {
            #expect(position.pieceAt(row: target.row, col: target.col) == nil)
        }
    }

    @Test("Empty board returns no targets")
    func emptyBoardNoTargets() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let targets = TargetSquareAnalysis.topTargets(position: position, player: .attacker, count: 5)
        #expect(targets.isEmpty)
    }

    @Test("High priority target near king for attacker")
    func highPriorityNearKing() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let isHigh = TargetSquareAnalysis.isHighPriorityTarget(row: 5, col: 6, position: position, player: .attacker)
        #expect(isHigh == true)
    }

    @Test("Defender targets edge and corner squares")
    func defenderTargetsEdge() {
        let position = Position.copenhagenStart()
        let targets = TargetSquareAnalysis.topTargets(position: position, player: .defender, count: 5)
        #expect(!targets.isEmpty)
    }

    @Test("Zero count returns empty array")
    func zeroCountReturnsEmpty() {
        let position = Position.copenhagenStart()
        let targets = TargetSquareAnalysis.topTargets(position: position, player: .attacker, count: 0)
        #expect(targets.isEmpty)
    }
}
