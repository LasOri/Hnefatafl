import Testing
@testable import Hnefatafl

@Suite("Opening Explorer Tests")
struct OpeningExplorerTests {

    @Test("suggest returns openings for empty board")
    func suggestForEmpty() {
        let suggestions = OpeningExplorer.suggest(moveHistory: [])
        #expect(!suggestions.isEmpty)
    }

    @Test("suggest narrows after first move")
    func narrowsAfterMove() {
        let all = OpeningExplorer.suggest(moveHistory: [])
        let opening = OpeningBook.allOpenings[0]
        let afterFirst = OpeningExplorer.suggest(moveHistory: [opening.moves[0]])
        #expect(afterFirst.count <= all.count)
    }

    @Test("display name for suggestion")
    func displayName() {
        let suggestions = OpeningExplorer.suggest(moveHistory: [])
        for s in suggestions {
            #expect(!s.name.isEmpty)
        }
    }

    @Test("suggestion has preview moves")
    func previewMoves() {
        let suggestions = OpeningExplorer.suggest(moveHistory: [])
        for s in suggestions {
            #expect(!s.previewMoves.isEmpty)
        }
    }

    @Test("no suggestions for unknown sequence")
    func noSuggestionsForUnknown() {
        let oddMove = Move(fromRow: 9, fromCol: 9, toRow: 9, toCol: 1)
        let suggestions = OpeningExplorer.suggest(moveHistory: [oddMove])
        #expect(suggestions.isEmpty)
    }

    @Test("OpeningSuggestion is Equatable")
    func equatable() {
        let a = OpeningSuggestion(name: "X", previewMoves: [])
        let b = OpeningSuggestion(name: "X", previewMoves: [])
        #expect(a == b)
    }
}
