import Testing
@testable import Hnefatafl

@Suite("MoveListFormatter Tests")
struct MoveListFormatterTests {

    @Test("empty list returns empty")
    func emptyListReturnsEmpty() {
        let result = MoveListFormatter.format(moves: [])
        #expect(result.isEmpty)
    }

    @Test("single move formatted with number")
    func singleMoveFormatted() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let result = MoveListFormatter.format(moves: [move])
        #expect(result.count == 1)
        #expect(result[0].hasPrefix("1."))
    }

    @Test("move numbering alternates")
    func moveNumberingAlternates() {
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let move2 = Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5)
        let result = MoveListFormatter.format(moves: [move1, move2])
        #expect(result[0].hasPrefix("1."))
        #expect(!result[1].hasPrefix("1."))
        #expect(!result[1].hasPrefix("2."))
    }

    @Test("square naming convention")
    func squareNamingConvention() {
        let name = MoveListFormatter.squareName(row: 0, col: 0)
        #expect(name == "a11")
        let name2 = MoveListFormatter.squareName(row: 10, col: 10)
        #expect(name2 == "k1")
        let name3 = MoveListFormatter.squareName(row: 5, col: 5)
        #expect(name3 == "f6")
    }

    @Test("compact format joins with space")
    func compactFormatJoins() {
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let move2 = Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5)
        let compact = MoveListFormatter.formatCompact(moves: [move1, move2])
        #expect(compact.contains(" "))
    }

    @Test("multiple moves alternate numbering")
    func multipleMovesNumbering() {
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let move2 = Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5)
        let move3 = Move(fromRow: 2, fromCol: 3, toRow: 4, toCol: 3)
        let move4 = Move(fromRow: 8, fromCol: 5, toRow: 6, toCol: 5)
        let result = MoveListFormatter.format(moves: [move1, move2, move3, move4])
        #expect(result[0].hasPrefix("1."))
        #expect(result[2].hasPrefix("2."))
        #expect(result.count == 4)
    }
}
