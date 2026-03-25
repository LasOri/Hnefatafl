import Testing
@testable import Hnefatafl

@Suite("Notation Parser Tests")
struct NotationParserTests {

    @Test("valid notation is parsed")
    func validNotationParsed() {
        let result = NotationParser.parse("a1-a5")
        #expect(result != nil)
        #expect(result?.fromCol == 0)
        #expect(result?.toCol == 0)
    }

    @Test("invalid notation returns nil")
    func invalidReturnsNil() {
        let result = NotationParser.parse("xyz")
        #expect(result == nil)
    }

    @Test("boundary squares parsed correctly")
    func boundarySquares() {
        let result = NotationParser.parse("a11-k11")
        #expect(result != nil)
        #expect(result?.fromRow == 0)
        #expect(result?.fromCol == 0)
        #expect(result?.toRow == 0)
        #expect(result?.toCol == 10)
    }

    @Test("corner squares parsed correctly")
    func cornerSquares() {
        let result = NotationParser.parse("a1-k11")
        #expect(result != nil)
        #expect(result?.fromRow == 10)
        #expect(result?.fromCol == 0)
        #expect(result?.toRow == 0)
        #expect(result?.toCol == 10)
    }

    @Test("columns a through k are valid")
    func columnsAtoK() {
        for c in 0..<11 {
            let col = String(UnicodeScalar(97 + c)!)
            let result = NotationParser.parse("\(col)1-\(col)2")
            #expect(result != nil)
            #expect(result?.fromCol == c)
        }
    }

    @Test("rows 1 through 11 are valid")
    func rows1to11() {
        for r in 1...11 {
            let result = NotationParser.parse("a\(r)-b\(r)")
            #expect(result != nil)
            #expect(result?.fromRow == 11 - r)
        }
    }
}
