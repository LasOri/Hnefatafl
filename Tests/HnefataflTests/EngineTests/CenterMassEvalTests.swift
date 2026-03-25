import Testing
@testable import Hnefatafl

@Suite("Center Mass Eval Tests")
struct CenterMassEvalTests {

    @Test("empty board returns nil center of mass")
    func emptyBoardNil() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(CenterMassEval.centerOfMass(position: pos, player: .attacker) == nil)
    }

    @Test("single center piece has center of mass at that position")
    func singlePieceAtCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let com = CenterMassEval.centerOfMass(position: pos, player: .attacker)
        #expect(com?.row == 5.0)
        #expect(com?.col == 5.0)
    }

    @Test("center piece has zero distance from center")
    func centerPieceZeroDistance() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let dist = CenterMassEval.distanceFromCenter(position: pos, player: .attacker)
        #expect(dist == 0)
    }

    @Test("corner piece has positive distance from center")
    func cornerPiecePositiveDistance() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let dist = CenterMassEval.distanceFromCenter(position: pos, player: .attacker)
        #expect(dist > 0)
    }

    @Test("distanceFromCenter zero for no pieces")
    func noPiecesZeroDistance() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(CenterMassEval.distanceFromCenter(position: pos, player: .attacker) == 0)
    }

    @Test("symmetric pieces have center near board center")
    func symmetricPiecesCentered() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .attacker
        cells[0 * 11 + 10] = .attacker
        cells[10 * 11 + 0] = .attacker
        cells[10 * 11 + 10] = .attacker
        let pos = Position(cells: cells)
        let com = CenterMassEval.centerOfMass(position: pos, player: .attacker)
        #expect(com?.row == 5.0)
        #expect(com?.col == 5.0)
    }

    @Test("king counts for defender center of mass")
    func kingCountsForDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let com = CenterMassEval.centerOfMass(position: pos, player: .defender)
        #expect(com != nil)
    }
}
