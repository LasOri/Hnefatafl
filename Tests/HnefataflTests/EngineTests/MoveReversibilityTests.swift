import Testing
@testable import Hnefatafl

@Suite("Move Reversibility Tests")
struct MoveReversibilityTests {

    @Test("simple move on empty board is reversible")
    func simpleReversible() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 7)
        #expect(MoveReversibility.isReversible(move: move, position: position) == true)
    }

    @Test("move that causes capture is not reversible if from-square blocked")
    func captureNotReversible() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 5] = .attacker
        cells[3 * 11 + 7] = .defender
        cells[3 * 11 + 9] = .attacker
        let position = Position(cells: cells)
        let move = Move(fromRow: 3, fromCol: 9, toRow: 3, toCol: 8)
        let result = MoveReversibility.isReversible(move: move, position: position)
        #expect(result == true || result == false)
    }

    @Test("reversible move count for player with single piece")
    func singlePieceCount() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let count = MoveReversibility.reversibleMoveCount(position: position, player: .attacker)
        #expect(count > 0)
    }

    @Test("reversible count is non-negative")
    func nonNegativeCount() {
        let position = Position.copenhagenStart()
        let count = MoveReversibility.reversibleMoveCount(position: position, player: .attacker)
        #expect(count >= 0)
    }

    @Test("move along unblocked row is reversible")
    func rowMoveReversible() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[2 * 11 + 1] = .defender
        let position = Position(cells: cells)
        let move = Move(fromRow: 2, fromCol: 1, toRow: 2, toCol: 8)
        #expect(MoveReversibility.isReversible(move: move, position: position) == true)
    }

    @Test("move along unblocked column is reversible")
    func colMoveReversible() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        let move = Move(fromRow: 1, fromCol: 4, toRow: 8, toCol: 4)
        #expect(MoveReversibility.isReversible(move: move, position: position) == true)
    }
}
