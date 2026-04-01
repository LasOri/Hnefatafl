import Testing
@testable import Hnefatafl

@Suite("EnhancedAIGameLoop Tests")
struct EnhancedAIGameLoopTests {

    @Test("returns nil for humanVsHuman mode")
    func humanVsHuman_returnsNil() {
        let game = Game()
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsHuman,
            difficulty: .medium
        )
        #expect(move == nil)
    }

    @Test("returns nil when it is the human's turn")
    func humanTurn_returnsNil() {
        let game = Game() // attacker starts
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .attacker),
            difficulty: .medium
        )
        #expect(move == nil)
    }

    @Test("returns a legal move for AI's turn at medium difficulty")
    func aiTurn_returnsLegalMove() {
        let game = Game() // attacker starts
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .medium
        )
        #expect(move != nil)
        if let move = move {
            let allMoves = game.position.allLegalMoves(for: game.currentPlayer)
            #expect(allMoves.contains(move))
        }
    }

    @Test("returns a move for starting position (not nil)")
    func startingPosition_returnsMoveNotNil() {
        let game = Game()
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .easy,
            personality: .aggressive
        )
        #expect(move != nil)
    }

    @Test("returns nil when game is over")
    func gameOver_returnsNil() {
        // King on corner = defender wins, game is not inProgress
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])

        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .hard
        )
        #expect(move == nil)
    }

    @Test("move is legal for the current position")
    func moveIsLegal() {
        let game = Game()
        guard let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .hard,
            personality: .balanced
        ) else {
            Issue.record("Expected a move")
            return
        }

        let piece = game.position.pieceAt(row: move.fromRow, col: move.fromCol)
        #expect(piece != nil)

        let pieceMoves = game.position.legalMoves(forPieceAtRow: move.fromRow, col: move.fromCol)
        #expect(pieceMoves.contains(move))
    }
}
