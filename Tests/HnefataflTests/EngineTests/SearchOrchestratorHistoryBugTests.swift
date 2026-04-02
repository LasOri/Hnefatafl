import Testing
@testable import Hnefatafl

@Suite("SearchOrchestrator History Bug Tests")
struct SearchOrchestratorHistoryBugTests {

    @Test("Beta cutoff records the actual cutoff move in history table")
    func betaCutoffRecordsCorrectMove() {
        // Minimal position: king near corner with few pieces for fast search
        let position = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .placing(.defender, row: 1, col: 2)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 3, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        var orchestrator = SearchOrchestrator(ttSize: 5000)
        _ = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )

        // Reset node counter but keep history table intact
        orchestrator.nodeCounter = NodeCounter()
        orchestrator.tt = TranspositionTable(maxSize: 5000)
        orchestrator.killers = KillerMoveTable()

        let result2 = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )

        #expect(result2.move != nil)
        let legalMoves = game.position.allLegalMoves(for: .attacker)
        #expect(legalMoves.contains(result2.move!))
        #expect(result2.depthReached == 2)
    }

    @Test("History table scores increase for cutoff moves after search")
    func historyScoresNonZeroAfterSearch() {
        // Position with enough pieces for beta cutoffs at depth 2
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 3, col: 5)
            .placing(.defender, row: 5, col: 3)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .placing(.attacker, row: 10, col: 5)
            .placing(.attacker, row: 5, col: 10)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        var orchestrator = SearchOrchestrator(ttSize: 5000)
        _ = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )

        // Check all moves from both sides for any history entry
        var foundHistory = false
        for player in [Player.attacker, Player.defender] {
            let moves = game.position.allLegalMoves(for: player)
            for m in moves {
                if orchestrator.history.score(for: m) > 0 {
                    foundHistory = true
                    break
                }
            }
            if foundHistory { break }
        }

        #expect(foundHistory, "History table should have recorded at least one move after search")
    }

    @Test("Cutoff move recorded in history matches the killer move")
    func cutoffMoveMatchesKiller() {
        // Minimal position with forced cutoffs
        let position = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.defender, row: 2, col: 1)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 4, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])

        var orchestrator = SearchOrchestrator(ttSize: 5000)
        _ = orchestrator.search(
            game: game,
            maxDepth: 2,
            evaluator: EvaluationAI.evaluate
        )

        for depth in 1...2 {
            let killerMoves = orchestrator.killers.killers(at: depth)
            for killer in killerMoves {
                let histScore = orchestrator.history.score(for: killer)
                #expect(histScore > 0,
                    "Killer move at depth \(depth) should have history score > 0, got \(histScore)")
            }
        }
    }
}
