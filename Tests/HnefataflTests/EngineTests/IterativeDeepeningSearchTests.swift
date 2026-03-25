import Testing
@testable import Hnefatafl

@Suite("IterativeDeepeningSearch Tests")
struct IterativeDeepeningSearchTests {

    @Test("search returns a result")
    func searchReturnsResult() {
        let position = Position.copenhagenStart()
        let result = IterativeDeepeningSearch.search(position: position, player: .attacker, maxDepth: 1)
        #expect(result.bestMove != nil)
    }

    @Test("depthReached matches maxDepth")
    func depthReachedMatchesMaxDepth() {
        let position = Position.copenhagenStart()
        let result = IterativeDeepeningSearch.search(position: position, player: .attacker, maxDepth: 2)
        #expect(result.depthReached == 2)
    }

    @Test("bestMove is legal")
    func bestMoveIsLegal() {
        let position = Position.copenhagenStart()
        let result = IterativeDeepeningSearch.search(position: position, player: .attacker, maxDepth: 1)
        let legalMoves = position.allLegalMoves(for: .attacker)
        #expect(result.bestMove != nil)
        #expect(legalMoves.contains(result.bestMove!))
    }

    @Test("depth 1 returns valid move")
    func depthOneReturnsValid() {
        let position = Position.copenhagenStart()
        let result = IterativeDeepeningSearch.search(position: position, player: .defender, maxDepth: 1)
        #expect(result.bestMove != nil)
        #expect(result.depthReached == 1)
    }

    @Test("empty board returns nil move")
    func emptyBoardReturnsNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = IterativeDeepeningSearch.search(position: position, player: .attacker, maxDepth: 2)
        #expect(result.bestMove == nil)
    }

    @Test("IDSearchResult is Equatable")
    func resultEquatable() {
        let a = IDSearchResult(bestMove: nil, score: 0, depthReached: 0)
        let b = IDSearchResult(bestMove: nil, score: 0, depthReached: 0)
        #expect(a == b)
    }
}
