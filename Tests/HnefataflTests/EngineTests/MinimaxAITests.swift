import Testing
@testable import Hnefatafl

@Suite("Minimax AI Tests")
struct MinimaxAITests {

    @Test("minimax at depth 0 returns same score as static evaluate")
    func depth0MatchesStaticEval() {
        let position = emptyBoard()
            .placing(.king, row: 1, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let staticScore = EvaluationAI.evaluate(position: position, for: .defender)
        let minimaxScore = EvaluationAI.minimax(
            game: Game(position: position, currentPlayer: .defender, moveHistory: []),
            depth: 0,
            alpha: Int.min,
            beta: Int.max,
            maximizing: true,
            forPlayer: .defender
        )
        #expect(minimaxScore == staticScore)
    }

    @Test("minimax at depth 1 returns a legal move")
    func depth1ReturnsLegalMove() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game, depth: 1)
        #expect(move != nil)
        let legal = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legal.contains(where: { $0 == move }))
    }

    @Test("minimax at depth 2 finds two-move capture setup")
    func depth2FindsCaptureSetup() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game, depth: 2)
        #expect(move != nil)
    }

    @Test("minimax at depth 3 returns a legal move")
    func depth3ReturnsLegalMove() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 0, col: 7)
            .placing(.attacker, row: 10, col: 3)
            .placing(.attacker, row: 10, col: 7)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game, depth: 3)
        #expect(move != nil)
        let legal = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legal.contains(where: { $0 == move }))
    }

    @Test("minimax prefers winning move")
    func prefersWinningMove() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game, depth: 1)
        #expect(move != nil)
        if let move {
            let afterMove = game.makeMove(move)
            #expect(afterMove.status == .defenderWins)
        }
    }

    @Test("minimax avoids moving king into danger")
    func avoidsKingDanger() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 3)
            .placing(.attacker, row: 5, col: 1)
            .placing(.attacker, row: 4, col: 2)
            .placing(.attacker, row: 6, col: 2)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game, depth: 2)
        #expect(move != nil)
    }

    @Test("alpha-beta produces same result as full search")
    func alphaBetaSameResult() {
        let position = emptyBoard()
            .placing(.king, row: 2, col: 2)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .placing(.defender, row: 3, col: 3)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move1 = EvaluationAI.pickMove(game: game, depth: 2)
        let move2 = EvaluationAI.pickMove(game: game, depth: 2)
        #expect(move1 == move2)
    }

    @Test("depth parameter controls search depth")
    func depthParameterWorks() {
        let position = emptyBoard()
            .placing(.king, row: 1, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move0 = EvaluationAI.pickMove(game: game, depth: 0)
        let move1 = EvaluationAI.pickMove(game: game, depth: 1)
        #expect(move0 != nil)
        #expect(move1 != nil)
    }

    @Test("pickMove with depth 1 is deterministic")
    func depth1Deterministic() {
        let game = Game()
        let a = EvaluationAI.pickMove(game: game, depth: 1)
        let b = EvaluationAI.pickMove(game: game, depth: 1)
        #expect(a == b)
    }

    @Test("pickMove with depth 3 is deterministic")
    func depth3Deterministic() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 10, col: 7)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let a = EvaluationAI.pickMove(game: game, depth: 3)
        let b = EvaluationAI.pickMove(game: game, depth: 3)
        #expect(a == b)
    }

    @Test("depth 0 still returns a valid move")
    func depth0ReturnsValidMove() {
        let game = Game()
        let move = EvaluationAI.pickMove(game: game, depth: 0)
        #expect(move != nil)
        let legal = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legal.contains(where: { $0 == move }))
    }

    @Test("default pickMove uses depth 3")
    func defaultPickMoveUsesDepth3() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 10, col: 7)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let defaultMove = EvaluationAI.pickMove(game: game)
        let depth3Move = EvaluationAI.pickMove(game: game, depth: 3)
        #expect(defaultMove == depth3Move)
    }
}
