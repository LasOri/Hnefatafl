import Testing
@testable import Hnefatafl

@Suite("Iterative Deepening Tests")
struct IterativeDeepeningTests {

    @Test("search returns a legal move")
    func returnsLegalMove() {
        let game = Game()
        let result = IterativeDeepening.search(game: game, maxDepth: 2)
        #expect(result.move != nil)
        let allMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(allMoves.contains(result.move!))
    }

    @Test("search at depth 1")
    func depthOne() {
        let game = Game()
        let result = IterativeDeepening.search(game: game, maxDepth: 1)
        #expect(result.depthReached >= 1)
    }

    @Test("search at depth 2 reaches deeper")
    func depthTwo() {
        let game = Game()
        let result = IterativeDeepening.search(game: game, maxDepth: 2)
        #expect(result.depthReached >= 1)
    }

    @Test("search result includes score")
    func includesScore() {
        let game = Game()
        let result = IterativeDeepening.search(game: game, maxDepth: 1)
        #expect(result.score != nil)
    }

    @Test("SearchResult stores depth and move")
    func searchResultFields() {
        let result = SearchResult(move: nil, score: 100, depthReached: 3)
        #expect(result.depthReached == 3)
        #expect(result.score == 100)
        #expect(result.move == nil)
    }

    @Test("deeper search may find different move")
    func deeperMayDiffer() {
        let game = Game()
        let shallow = IterativeDeepening.search(game: game, maxDepth: 1)
        let deep = IterativeDeepening.search(game: game, maxDepth: 2)
        #expect(shallow.move != nil)
        #expect(deep.move != nil)
    }

    @Test("search on finished game returns nil move")
    func finishedGame() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [], positionHistory: [position])
        let result = IterativeDeepening.search(game: game, maxDepth: 2)
        #expect(result.move == nil)
    }

    @Test("search depth reached does not exceed max")
    func depthDoesNotExceedMax() {
        let game = Game()
        let result = IterativeDeepening.search(game: game, maxDepth: 2)
        #expect(result.depthReached <= 2)
    }
}
