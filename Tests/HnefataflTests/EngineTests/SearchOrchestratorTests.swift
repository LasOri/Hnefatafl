import Testing
@testable import Hnefatafl

@Suite("SearchOrchestrator Tests")
struct SearchOrchestratorTests {

    @Test("Search returns a legal move from start position at small depth")
    func returnsLegalMove() {
        let game = Game()
        var orchestrator = SearchOrchestrator(ttSize: 1000)
        let result = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )
        #expect(result.move != nil)
        let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legalMoves.contains(result.move!))
    }

    @Test("Search with TT stores entries after search")
    func ttStoresEntries() {
        let game = Game()
        var orchestrator = SearchOrchestrator(ttSize: 10000)
        _ = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )
        #expect(orchestrator.tt.count > 0)
    }

    @Test("Search result includes score and depth reached")
    func resultIncludesScoreAndDepth() {
        let game = Game()
        var orchestrator = SearchOrchestrator(ttSize: 1000)
        let result = orchestrator.search(
            game: game,
            maxDepth: 3,
            evaluator: EvaluationAI.evaluate
        )
        #expect(result.depthReached == 3)
        // Score should be a finite integer, not Int.min or Int.max
        #expect(result.score > Int.min + 1000)
        #expect(result.score < Int.max - 1000)
    }

    @Test("Search with depth 0 returns static evaluation")
    func depthZeroReturnsStaticEval() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        var orchestrator = SearchOrchestrator(ttSize: 100)
        let result = orchestrator.search(
            game: game,
            maxDepth: 0,
            evaluator: EvaluationAI.evaluate
        )
        let expectedScore = EvaluationAI.evaluate(position: position, for: .defender)
        #expect(result.move == nil)
        #expect(result.score == expectedScore)
        #expect(result.depthReached == 0)
    }

    @Test("Search is deterministic for same position")
    func deterministic() {
        let game = Game()
        var orchestrator1 = SearchOrchestrator(ttSize: 1000)
        var orchestrator2 = SearchOrchestrator(ttSize: 1000)
        let result1 = orchestrator1.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )
        let result2 = orchestrator2.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )
        #expect(result1.move == result2.move)
        #expect(result1.score == result2.score)
        #expect(result1.depthReached == result2.depthReached)
    }

    @Test("Search handles terminal position where game is already won")
    func handlesTerminalPosition() {
        // King at corner means defender already won
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        var orchestrator = SearchOrchestrator(ttSize: 100)
        let result = orchestrator.search(
            game: game,
            maxDepth: 3,
            evaluator: EvaluationAI.evaluate
        )
        #expect(result.move == nil)
        #expect(result.depthReached == 0)
    }
}
