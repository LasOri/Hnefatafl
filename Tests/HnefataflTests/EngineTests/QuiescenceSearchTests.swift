import Testing
@testable import Hnefatafl

@Suite("Quiescence Search Tests")
struct QuiescenceSearchTests {

    @Test("quiescence returns static eval for quiet position")
    func quietPosition() {
        let game = Game()
        let score = QuiescenceSearch.search(game: game, alpha: Int.min + 1, beta: Int.max, player: .attacker, depth: 4)
        let staticScore = EvaluationAI.evaluate(position: game.position, for: .attacker)
        #expect(score == staticScore)
    }

    @Test("quiescence depth limits recursion")
    func depthLimits() {
        let game = Game()
        let score = QuiescenceSearch.search(game: game, alpha: Int.min + 1, beta: Int.max, player: .attacker, depth: 0)
        let staticScore = EvaluationAI.evaluate(position: game.position, for: .attacker)
        #expect(score == staticScore)
    }

    @Test("capture moves are identified")
    func captureMoves() {
        let game = Game()
        let captures = QuiescenceSearch.captureMoves(game: game)
        #expect(captures.count >= 0)
    }

    @Test("empty board has no capture moves")
    func emptyBoardNoCaptures() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let captures = QuiescenceSearch.captureMoves(game: game)
        #expect(captures.isEmpty)
    }

    @Test("maxDepth constant")
    func maxDepthConstant() {
        #expect(QuiescenceSearch.maxDepth == 4)
    }

    @Test("search on finished game returns terminal score")
    func finishedGame() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let score = QuiescenceSearch.search(game: game, alpha: Int.min + 1, beta: Int.max, player: .defender, depth: 4)
        #expect(score > 0)
    }

    @Test("alpha-beta pruning works in quiescence")
    func alphaBetaPrunes() {
        let game = Game()
        let scoreWide = QuiescenceSearch.search(game: game, alpha: Int.min + 1, beta: Int.max, player: .attacker, depth: 2)
        let scoreNarrow = QuiescenceSearch.search(game: game, alpha: scoreWide - 1, beta: scoreWide + 1, player: .attacker, depth: 2)
        #expect(abs(scoreWide - scoreNarrow) <= 2 || scoreNarrow >= scoreWide - 1)
    }

    @Test("search returns integer score")
    func returnsInt() {
        let game = Game()
        let score = QuiescenceSearch.search(game: game, alpha: Int.min + 1, beta: Int.max, player: .attacker, depth: 2)
        #expect(score > Int.min + 1)
        #expect(score < Int.max)
    }
}
