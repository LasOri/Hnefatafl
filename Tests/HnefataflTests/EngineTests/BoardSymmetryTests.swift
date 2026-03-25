import Testing
@testable import Hnefatafl

@Suite("Board Symmetry Tests")
struct BoardSymmetryTests {

    @Test("starting position has symmetry")
    func startSymmetry() {
        let position = Position.copenhagenStart()
        #expect(BoardSymmetry.hasVerticalSymmetry(position: position))
    }

    @Test("starting position has horizontal symmetry")
    func horizontalSymmetry() {
        let position = Position.copenhagenStart()
        #expect(BoardSymmetry.hasHorizontalSymmetry(position: position))
    }

    @Test("starting position has rotational symmetry")
    func rotationalSymmetry() {
        let position = Position.copenhagenStart()
        #expect(BoardSymmetry.hasRotationalSymmetry(position: position))
    }

    @Test("asymmetric position has no symmetry")
    func asymmetric() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[55] = .king
        let position = Position(cells: cells)
        #expect(!BoardSymmetry.hasVerticalSymmetry(position: position))
    }

    @Test("symmetry count for start")
    func symmetryCount() {
        let position = Position.copenhagenStart()
        let count = BoardSymmetry.symmetryCount(position: position)
        #expect(count > 0)
    }

    @Test("canonical hash reduces equivalent positions")
    func canonicalHash() {
        let position = Position.copenhagenStart()
        let hash = BoardSymmetry.canonicalHash(position: position)
        #expect(hash > 0)
    }
}
