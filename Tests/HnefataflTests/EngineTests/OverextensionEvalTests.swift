import Testing
@testable import Hnefatafl

@Suite("OverextensionEval Tests")
struct OverextensionEvalTests {

    @Test("empty board has no overextended pieces")
    func emptyBoardNone() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let result = OverextensionEval.overextendedPieces(position: pos, player: .attacker)
        #expect(result.isEmpty)
    }

    @Test("lone attacker near center is overextended")
    func loneAttackerCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let result = OverextensionEval.overextendedPieces(position: pos, player: .attacker)
        #expect(result.count == 1)
    }

    @Test("supported attacker near center is not overextended")
    func supportedAttackerNotOverextended() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let result = OverextensionEval.overextendedPieces(position: pos, player: .attacker)
        #expect(result.isEmpty)
    }

    @Test("penalty proportional to overextended count")
    func penaltyProportional() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let penalty = OverextensionEval.overextensionPenalty(position: pos, player: .attacker)
        #expect(penalty == 5)
    }

    @Test("defender far from center is overextended")
    func defenderFarFromCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .defender
        let pos = Position(cells: cells)
        let result = OverextensionEval.overextendedPieces(position: pos, player: .defender)
        #expect(result.count == 1)
    }

    @Test("penalty is zero when no overextension")
    func zeroPenalty() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        let pos = Position(cells: cells)
        let penalty = OverextensionEval.overextensionPenalty(position: pos, player: .attacker)
        #expect(penalty == 0)
    }
}
