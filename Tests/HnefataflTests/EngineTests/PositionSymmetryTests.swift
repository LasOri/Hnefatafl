import Testing
@testable import Hnefatafl

@Suite("Position Symmetry Tests")
struct PositionSymmetryTests {

    @Test("starting position has full symmetry")
    func startHasFullSymmetry() {
        let position = Position.copenhagenStart()
        let sym = PositionSymmetry.detectSymmetry(position: position)
        #expect(sym == .full)
    }

    @Test("empty board has full symmetry")
    func emptyBoardFull() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let sym = PositionSymmetry.detectSymmetry(position: position)
        #expect(sym == .full)
    }

    @Test("asymmetric position returns none")
    func asymmetricNone() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.king, row: 5, col: 5)
            .build()
        let sym = PositionSymmetry.detectSymmetry(position: position)
        #expect(sym == .none)
    }

    @Test("horizontally symmetric position detected")
    func horizontalOnly() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 0, col: 7)
            .placing(.king, row: 5, col: 5)
            .build()
        let sym = PositionSymmetry.detectSymmetry(position: position)
        #expect(sym == .horizontal || sym == .full)
    }

    @Test("SymmetryType supports equality")
    func symmetryEquality() {
        #expect(SymmetryType.none == SymmetryType.none)
        #expect(SymmetryType.full != SymmetryType.none)
    }
}
