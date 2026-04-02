import Testing
@testable import Hnefatafl

@Suite("EnhancedAIGameLoop No Warm-up Tests")
struct EnhancedAIGameLoopNoWarmupTests {

    @Test("selectMove returns a legal move without UtilityIntegration warm-up")
    func selectMoveReturnsLegalMoveWithoutWarmup() {
        let game = Game()
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .medium
        )
        #expect(move != nil)
        if let move = move {
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            #expect(legalMoves.contains(move))
        }
    }

    @Test("selectMove works for easy difficulty without warm-up")
    func selectMoveEasyDifficulty() {
        let game = Game()
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .easy
        )
        #expect(move != nil)
    }

    @Test("selectMove works for hard difficulty without warm-up")
    func selectMoveHardDifficulty() {
        let game = Game()
        let move = EnhancedAIGameLoop.selectMove(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .hard
        )
        #expect(move != nil)
    }

    @Test("selectMoveWithStats returns valid result without warm-up")
    func selectMoveWithStatsNoWarmup() {
        let game = Game()
        let result = EnhancedAIGameLoop.selectMoveWithStats(
            game: game,
            mode: .humanVsAI(humanSide: .defender),
            difficulty: .medium
        )
        #expect(result.move != nil)
        if let move = result.move {
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            #expect(legalMoves.contains(move))
        }
    }
}
