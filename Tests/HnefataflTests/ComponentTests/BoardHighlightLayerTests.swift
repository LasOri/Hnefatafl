import Testing
@testable import Hnefatafl

@Suite("BoardHighlightLayer Tests")
struct BoardHighlightLayerTests {

    @Test("no selection returns empty")
    func noSelectionEmpty() {
        let position = Position.copenhagenStart()
        let highlights = BoardHighlightLayer.highlights(selectedRow: nil, selectedCol: nil, lastMove: nil, position: position)
        #expect(highlights.isEmpty)
    }

    @Test("selected square included")
    func selectedSquareIncluded() {
        let position = Position.copenhagenStart()
        let highlights = BoardHighlightLayer.highlights(selectedRow: 0, selectedCol: 3, lastMove: nil, position: position)
        #expect(highlights.contains(HighlightSquare(row: 0, col: 3, type: .selected)))
    }

    @Test("legal moves highlighted")
    func legalMovesHighlighted() {
        let position = Position.copenhagenStart()
        let highlights = BoardHighlightLayer.highlights(selectedRow: 0, selectedCol: 3, lastMove: nil, position: position)
        let legalMoveHighlights = highlights.filter { $0.type == .legalMove }
        let expectedMoves = position.legalMoves(forPieceAtRow: 0, col: 3)
        #expect(legalMoveHighlights.count == expectedMoves.count)
    }

    @Test("last move highlighted")
    func lastMoveHighlighted() {
        let position = Position.copenhagenStart()
        let last = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let highlights = BoardHighlightLayer.highlights(selectedRow: nil, selectedCol: nil, lastMove: last, position: position)
        #expect(highlights.contains(HighlightSquare(row: 0, col: 3, type: .lastMove)))
        #expect(highlights.contains(HighlightSquare(row: 0, col: 2, type: .lastMove)))
    }

    @Test("both selection and last move")
    func bothSelectionAndLastMove() {
        let position = Position.copenhagenStart()
        let last = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let highlights = BoardHighlightLayer.highlights(selectedRow: 0, selectedCol: 5, lastMove: last, position: position)
        let selected = highlights.filter { $0.type == .selected }
        let lastMoves = highlights.filter { $0.type == .lastMove }
        #expect(selected.count == 1)
        #expect(lastMoves.count == 2)
    }

    @Test("no legal moves for empty square")
    func noLegalMovesEmptySquare() {
        let position = Position.copenhagenStart()
        let highlights = BoardHighlightLayer.highlights(selectedRow: 2, selectedCol: 2, lastMove: nil, position: position)
        let legalMoveHighlights = highlights.filter { $0.type == .legalMove }
        #expect(legalMoveHighlights.isEmpty)
    }
}
