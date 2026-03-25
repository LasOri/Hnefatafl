import Testing
@testable import Hnefatafl

@Suite("AlgebraicNotation Tests")
struct AlgebraicNotationTests {

    @Test("row 0 col 0 converts to a11")
    func topLeftCorner() {
        let notation = AlgebraicNotation.squareName(row: 0, col: 0)
        #expect(notation == "a11")
    }

    @Test("row 10 col 0 converts to a1")
    func bottomLeftCorner() {
        let notation = AlgebraicNotation.squareName(row: 10, col: 0)
        #expect(notation == "a1")
    }

    @Test("row 10 col 10 converts to k1")
    func bottomRightCorner() {
        let notation = AlgebraicNotation.squareName(row: 10, col: 10)
        #expect(notation == "k1")
    }

    @Test("row 0 col 10 converts to k11")
    func topRightCorner() {
        let notation = AlgebraicNotation.squareName(row: 0, col: 10)
        #expect(notation == "k11")
    }

    @Test("center square row 5 col 5 converts to f6")
    func centerSquare() {
        let notation = AlgebraicNotation.squareName(row: 5, col: 5)
        #expect(notation == "f6")
    }

    @Test("parse a11 returns row 0 col 0")
    func parseTopLeft() {
        let coords = AlgebraicNotation.parseSquare("a11")
        #expect(coords?.row == 0)
        #expect(coords?.col == 0)
    }

    @Test("parse k1 returns row 10 col 10")
    func parseBottomRight() {
        let coords = AlgebraicNotation.parseSquare("k1")
        #expect(coords?.row == 10)
        #expect(coords?.col == 10)
    }

    @Test("parse invalid notation returns nil")
    func parseInvalid() {
        #expect(AlgebraicNotation.parseSquare("z99") == nil)
        #expect(AlgebraicNotation.parseSquare("") == nil)
        #expect(AlgebraicNotation.parseSquare("a0") == nil)
        #expect(AlgebraicNotation.parseSquare("l1") == nil)
    }

    @Test("format move produces dash-separated notation")
    func formatMove() {
        let move = Move(fromRow: 10, fromCol: 3, toRow: 5, toCol: 3)
        let notation = AlgebraicNotation.formatMove(move)
        #expect(notation == "d1-d6")
    }

    @Test("parse move from notation string")
    func parseMove() {
        let move = AlgebraicNotation.parseMove("d1-d6")
        #expect(move?.fromRow == 10)
        #expect(move?.fromCol == 3)
        #expect(move?.toRow == 5)
        #expect(move?.toCol == 3)
    }

    @Test("parse invalid move returns nil")
    func parseInvalidMove() {
        #expect(AlgebraicNotation.parseMove("") == nil)
        #expect(AlgebraicNotation.parseMove("d1") == nil)
        #expect(AlgebraicNotation.parseMove("d1-z99") == nil)
    }

    @Test("round trip move: format then parse is identity")
    func roundTripMove() {
        let original = Move(fromRow: 3, fromCol: 7, toRow: 3, toCol: 2)
        let notation = AlgebraicNotation.formatMove(original)
        let parsed = AlgebraicNotation.parseMove(notation)
        #expect(parsed == original)
    }

    @Test("round trip square: name then parse is identity")
    func roundTripSquare() {
        for row in 0..<11 {
            for col in 0..<11 {
                let name = AlgebraicNotation.squareName(row: row, col: col)
                let coords = AlgebraicNotation.parseSquare(name)
                #expect(coords?.row == row)
                #expect(coords?.col == col)
            }
        }
    }

    @Test("all column letters are a through k")
    func columnLetters() {
        let expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]
        for (col, letter) in expected.enumerated() {
            let name = AlgebraicNotation.squareName(row: 10, col: col)
            #expect(name.hasPrefix(letter))
        }
    }
}
