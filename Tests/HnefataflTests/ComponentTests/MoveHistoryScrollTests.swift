import Testing
@testable import Hnefatafl

@Suite("MoveHistoryScroll Tests")
struct MoveHistoryScrollTests {

    @Test("visible moves returns correct slice")
    func visibleMovesSlice() {
        let moves = [
            Move(fromRow: 0, fromCol: 1, toRow: 0, toCol: 3),
            Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 7),
            Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 1),
            Move(fromRow: 1, fromCol: 0, toRow: 4, toCol: 0),
        ]
        let scroll = MoveHistoryScroll(moves: moves, visibleStart: 1, visibleCount: 2)
        #expect(scroll.visibleMoves.count == 2)
        #expect(scroll.visibleMoves[0] == moves[1])
    }

    @Test("can scroll down when more moves exist")
    func canScrollDown() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5),
            Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 5),
            Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 5),
        ]
        let scroll = MoveHistoryScroll(moves: moves, visibleStart: 0, visibleCount: 2)
        #expect(scroll.canScrollDown == true)
    }

    @Test("cannot scroll down at end")
    func cannotScrollDownAtEnd() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5),
            Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 5),
        ]
        let scroll = MoveHistoryScroll(moves: moves, visibleStart: 0, visibleCount: 2)
        #expect(scroll.canScrollDown == false)
    }

    @Test("empty moves array returns empty visible")
    func emptyMovesArray() {
        let scroll = MoveHistoryScroll(moves: [], visibleStart: 0, visibleCount: 5)
        #expect(scroll.visibleMoves.isEmpty)
        #expect(scroll.canScrollDown == false)
    }

    @Test("visible start beyond array returns empty")
    func beyondArrayEmpty() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)]
        let scroll = MoveHistoryScroll(moves: moves, visibleStart: 10, visibleCount: 5)
        #expect(scroll.visibleMoves.isEmpty)
    }

    @Test("equatable conformance works")
    func equatable() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)]
        let a = MoveHistoryScroll(moves: moves, visibleStart: 0, visibleCount: 1)
        let b = MoveHistoryScroll(moves: moves, visibleStart: 0, visibleCount: 1)
        #expect(a == b)
    }
}
