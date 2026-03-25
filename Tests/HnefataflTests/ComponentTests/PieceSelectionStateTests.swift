import Testing
@testable import Hnefatafl

@Suite("Piece Selection State Tests")
struct PieceSelectionStateTests {

    @Test("has selection when row and col are set")
    func hasSelectionTrue() {
        let state = PieceSelectionState(selectedRow: 3, selectedCol: 5, validMoves: [])
        #expect(state.hasSelection == true)
    }

    @Test("no selection when row is nil")
    func noSelectionNilRow() {
        let state = PieceSelectionState(selectedRow: nil, selectedCol: 5, validMoves: [])
        #expect(state.hasSelection == false)
    }

    @Test("no selection when col is nil")
    func noSelectionNilCol() {
        let state = PieceSelectionState(selectedRow: 3, selectedCol: nil, validMoves: [])
        #expect(state.hasSelection == false)
    }

    @Test("selected position returns tuple when both set")
    func selectedPositionPresent() {
        let state = PieceSelectionState(selectedRow: 4, selectedCol: 7, validMoves: [])
        let pos = state.selectedPosition
        #expect(pos?.row == 4)
        #expect(pos?.col == 7)
    }

    @Test("selected position returns nil when no selection")
    func selectedPositionNil() {
        let state = PieceSelectionState(selectedRow: nil, selectedCol: nil, validMoves: [])
        #expect(state.selectedPosition == nil)
    }

    @Test("valid moves are stored")
    func validMovesStored() {
        let moves = [
            Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 8),
            Move(fromRow: 3, fromCol: 5, toRow: 7, toCol: 5)
        ]
        let state = PieceSelectionState(selectedRow: 3, selectedCol: 5, validMoves: moves)
        #expect(state.validMoves.count == 2)
    }

    @Test("equatable compares all fields")
    func equatable() {
        let moves = [Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 5)]
        let a = PieceSelectionState(selectedRow: 1, selectedCol: 1, validMoves: moves)
        let b = PieceSelectionState(selectedRow: 1, selectedCol: 1, validMoves: moves)
        #expect(a == b)
    }
}
