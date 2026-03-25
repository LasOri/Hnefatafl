import Testing
@testable import Hnefatafl

@Suite("Move Notation Display Tests")
struct MoveNotationDisplayTests {

    @Test("algebraic notation for move")
    func algebraicNotation() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let notation = MoveNotationDisplay.algebraic(move)
        #expect(notation == "A1-F1")
    }

    @Test("coordinate notation")
    func coordinateNotation() {
        let move = Move(fromRow: 4, fromCol: 3, toRow: 4, toCol: 7)
        let notation = MoveNotationDisplay.coordinate(move)
        #expect(notation.contains("D5"))
        #expect(notation.contains("H5"))
    }

    @Test("compact notation")
    func compactNotation() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let notation = MoveNotationDisplay.compact(move)
        #expect(!notation.isEmpty)
        #expect(notation.count < 10)
    }

    @Test("move pair formatting")
    func movePair() {
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3)
        let pair = MoveNotationDisplay.pair(number: 1, attacker: m1, defender: m2)
        #expect(pair.contains("1."))
    }

    @Test("column label A-K")
    func columnLabel() {
        #expect(MoveNotationDisplay.columnLabel(0) == "A")
        #expect(MoveNotationDisplay.columnLabel(10) == "K")
    }

    @Test("row label 1-11")
    func rowLabel() {
        #expect(MoveNotationDisplay.rowLabel(0) == "1")
        #expect(MoveNotationDisplay.rowLabel(10) == "11")
    }

    @Test("full game notation")
    func fullGameNotation() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),
        ]
        let notation = MoveNotationDisplay.gameNotation(moves: moves)
        #expect(notation.contains("1."))
    }
}
