import Testing
@testable import Hnefatafl

@Suite("OpeningBookLookup Tests")
struct OpeningBookLookupTests {

    @Test("returns first move of an opening when moveHistory is empty")
    func returnsFirstMoveOnEmptyHistory() {
        let game = Game()
        let move = OpeningBookLookup.lookup(game: game)

        #expect(move != nil)
        // The returned move should be the first move of some opening
        let firstMoves = OpeningBook.allOpenings.map { $0.moves[0] }
        #expect(firstMoves.contains(move!))
    }

    @Test("returns second move when first move matches an opening")
    func returnsSecondMoveAfterFirstMatch() {
        // Use "Diamond Attack": first move (0,5)->(2,5), second move (5,3)->(2,3)
        let opening = OpeningBook.allOpenings[0]
        let firstMove = opening.moves[0]

        var game = Game()
        game = game.makeMove(firstMove)

        let move = OpeningBookLookup.lookup(game: game)

        #expect(move != nil)
        #expect(move == opening.moves[1])
    }

    @Test("returns nil when moveHistory does not match any opening")
    func returnsNilForNonMatchingHistory() {
        // Make a move that is not the first move of any opening
        let oddMove = Move(fromRow: 0, fromCol: 4, toRow: 1, toCol: 4)
        let game = Game()
        let movedGame = game.makeMove(oddMove)

        let move = OpeningBookLookup.lookup(game: movedGame)
        #expect(move == nil)
    }

    @Test("returns nil when past all opening moves")
    func returnsNilWhenPastOpeningMoves() {
        // Play both moves of "Diamond Attack", then lookup should return nil
        let opening = OpeningBook.allOpenings[0]
        var game = Game()
        for m in opening.moves {
            game = game.makeMove(m)
        }

        let move = OpeningBookLookup.lookup(game: game)
        #expect(move == nil)
    }

    @Test("returned move is legal for the position")
    func returnedMoveIsLegal() {
        let game = Game()
        guard let move = OpeningBookLookup.lookup(game: game) else {
            Issue.record("Expected a move from lookup")
            return
        }

        let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legalMoves.contains(move))
    }

    @Test("all opening book moves returned across sequences are valid")
    func allReturnedMovesAreValid() {
        // Walk through every opening and verify each suggested move is legal
        for opening in OpeningBook.allOpenings {
            var game = Game()
            for i in 0..<opening.moves.count {
                guard let suggested = OpeningBookLookup.lookup(game: game) else {
                    break
                }
                let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
                #expect(legalMoves.contains(suggested),
                        "Move \(i) of \(opening.name) is not legal")
                game = game.makeMove(opening.moves[i])
            }
        }
    }
}
