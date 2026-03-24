import Testing
@testable import Hnefatafl

@Suite("Opening Book Tests")
struct OpeningBookTests {

    @Test("OpeningBook has named openings")
    func hasOpenings() {
        let openings = OpeningBook.allOpenings
        #expect(!openings.isEmpty)
    }

    @Test("each opening has a name and moves")
    func openingsHaveNameAndMoves() {
        for opening in OpeningBook.allOpenings {
            #expect(!opening.name.isEmpty)
            #expect(!opening.moves.isEmpty)
        }
    }

    @Test("detect returns nil for empty move history")
    func nilForEmpty() {
        let result = OpeningBook.detect(moves: [])
        #expect(result == nil)
    }

    @Test("detect matches known opening sequence")
    func matchesKnown() {
        let opening = OpeningBook.allOpenings[0]
        let result = OpeningBook.detect(moves: opening.moves)
        #expect(result == opening.name)
    }

    @Test("detect returns nil for unknown sequence")
    func nilForUnknown() {
        let randomMove = Move(fromRow: 0, fromCol: 5, toRow: 4, toCol: 5)
        let result = OpeningBook.detect(moves: [randomMove])
        #expect(result == nil)
    }

    @Test("partial match detects opening prefix")
    func partialMatch() {
        let opening = OpeningBook.allOpenings[0]
        guard opening.moves.count > 1 else { return }
        let prefix = Array(opening.moves.prefix(1))
        let result = OpeningBook.detectPartial(moves: prefix)
        #expect(!result.isEmpty)
    }

    @Test("Opening is equatable")
    func equatable() {
        let a = Opening(name: "Test", moves: [Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)])
        let b = Opening(name: "Test", moves: [Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)])
        #expect(a == b)
    }

    @Test("openings use valid board coordinates")
    func validCoordinates() {
        for opening in OpeningBook.allOpenings {
            for move in opening.moves {
                #expect(move.fromRow >= 0 && move.fromRow < 11)
                #expect(move.fromCol >= 0 && move.fromCol < 11)
                #expect(move.toRow >= 0 && move.toRow < 11)
                #expect(move.toCol >= 0 && move.toCol < 11)
            }
        }
    }
}
