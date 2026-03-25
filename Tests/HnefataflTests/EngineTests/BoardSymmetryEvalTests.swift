import Testing
@testable import Hnefatafl

@Suite("Board Symmetry Eval Tests")
struct BoardSymmetryEvalTests {

    @Test("empty board is perfectly symmetric horizontally")
    func emptyHorizontal() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(BoardSymmetryEval.horizontalSymmetry(position: position) == 1.0)
    }

    @Test("empty board is perfectly symmetric vertically")
    func emptyVertical() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(BoardSymmetryEval.verticalSymmetry(position: position) == 1.0)
    }

    @Test("copenhagen start has high horizontal symmetry")
    func copenhagenHorizontal() {
        let position = Position.copenhagenStart()
        let sym = BoardSymmetryEval.horizontalSymmetry(position: position)
        #expect(sym > 0.8)
    }

    @Test("copenhagen start has high vertical symmetry")
    func copenhagenVertical() {
        let position = Position.copenhagenStart()
        let sym = BoardSymmetryEval.verticalSymmetry(position: position)
        #expect(sym > 0.8)
    }

    @Test("asymmetric position has low symmetry")
    func asymmetric() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .attacker
        cells[0 * 11 + 1] = .attacker
        cells[0 * 11 + 2] = .attacker
        let position = Position(cells: cells)
        let hSym = BoardSymmetryEval.horizontalSymmetry(position: position)
        #expect(hSym < 1.0)
    }

    @Test("symmetry values are between 0 and 1")
    func boundedValues() {
        let position = Position.copenhagenStart()
        let h = BoardSymmetryEval.horizontalSymmetry(position: position)
        let v = BoardSymmetryEval.verticalSymmetry(position: position)
        #expect(h >= 0.0 && h <= 1.0)
        #expect(v >= 0.0 && v <= 1.0)
    }
}
