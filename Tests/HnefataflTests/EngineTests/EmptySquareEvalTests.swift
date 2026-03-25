import Testing
@testable import Hnefatafl

@Suite("EmptySquareEval Tests")
struct EmptySquareEvalTests {

    @Test("start position empty near king is non-negative")
    func startPositionEmptyNearKing() {
        let pos = Position.copenhagenStart()
        let count = EmptySquareEval.emptyNearKing(position: pos)
        #expect(count >= 0)
    }

    @Test("no king returns zero for emptyNearKing")
    func noKingReturnsZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let count = EmptySquareEval.emptyNearKing(position: pos)
        #expect(count == 0)
    }

    @Test("king surrounded by pieces has few empty squares")
    func kingSurrounded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[6 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .defender
        cells[5 * 11 + 6] = .defender
        let pos = Position(cells: cells)
        let empty = EmptySquareEval.emptyNearKing(position: pos)
        let allEmpty = 4 + 8
        #expect(empty < allEmpty)
    }

    @Test("strategic empty squares returns zero with no king")
    func strategicNoKing() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let count = EmptySquareEval.strategicEmptySquares(position: pos)
        #expect(count == 0)
    }

    @Test("strategic empty squares positive with king on escape line")
    func strategicWithKingOnLine() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let count = EmptySquareEval.strategicEmptySquares(position: pos)
        #expect(count > 0)
    }

    @Test("empty board with king has maximum empty near king")
    func kingAloneMaxEmpty() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let count = EmptySquareEval.emptyNearKing(position: pos)
        #expect(count == 12)
    }
}
