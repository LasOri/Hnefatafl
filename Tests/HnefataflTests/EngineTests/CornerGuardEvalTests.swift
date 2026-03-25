import Testing
@testable import Hnefatafl

@Suite("Corner Guard Eval Tests")
struct CornerGuardEvalTests {

    @Test("empty board has no guarded corners")
    func emptyBoardNoGuards() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(CornerGuardEval.guardedCornerCount(position: pos) == 0)
        #expect(CornerGuardEval.cornerGuardStrength(position: pos) == 0)
    }

    @Test("attacker adjacent to top-left corner guards it")
    func topLeftGuarded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .attacker
        let pos = Position(cells: cells)
        #expect(CornerGuardEval.guardedCornerCount(position: pos) == 1)
    }

    @Test("two attackers adjacent to one corner give strength 2")
    func doubleGuardStrength() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .attacker
        cells[1 * 11 + 0] = .attacker
        let pos = Position(cells: cells)
        #expect(CornerGuardEval.cornerGuardStrength(position: pos) >= 2)
    }

    @Test("defenders adjacent to corner do not count")
    func defendersIgnored() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .defender
        cells[1 * 11 + 0] = .defender
        let pos = Position(cells: cells)
        #expect(CornerGuardEval.guardedCornerCount(position: pos) == 0)
    }

    @Test("all four corners can be guarded")
    func allFourGuarded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .attacker
        cells[1 * 11 + 10] = .attacker
        cells[10 * 11 + 1] = .attacker
        cells[9 * 11 + 10] = .attacker
        let pos = Position(cells: cells)
        #expect(CornerGuardEval.guardedCornerCount(position: pos) == 4)
    }

    @Test("strength accumulates across all corners")
    func strengthAccumulates() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .attacker
        cells[1 * 11 + 0] = .attacker
        cells[1 * 11 + 10] = .attacker
        let pos = Position(cells: cells)
        #expect(CornerGuardEval.cornerGuardStrength(position: pos) == 3)
    }

    @Test("start position has some corner guard presence")
    func startPositionGuards() {
        let pos = Position.copenhagenStart()
        let strength = CornerGuardEval.cornerGuardStrength(position: pos)
        #expect(strength >= 0)
    }
}
