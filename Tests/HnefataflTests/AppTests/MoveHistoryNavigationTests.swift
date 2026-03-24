import Testing
@testable import Hnefatafl

@Suite("Move History Navigation Tests")
struct MoveHistoryNavigationTests {

    @Test("MoveNavigator step count matches history")
    func stepCount() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        #expect(MoveNavigator.stepCount(game: game) == 2)
    }

    @Test("MoveNavigator step 0 is initial position")
    func stepZero() {
        let game = Game()
        let pos = MoveNavigator.position(at: 0, in: game)
        #expect(pos == Position.copenhagenStart())
    }

    @Test("MoveNavigator last step is current position")
    func lastStep() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let last = MoveNavigator.stepCount(game: game) - 1
        let pos = MoveNavigator.position(at: last, in: game)
        #expect(pos == game.position)
    }

    @Test("MoveNavigator clamps negative step")
    func clampNegative() {
        let game = Game()
        let pos = MoveNavigator.position(at: -1, in: game)
        #expect(pos == Position.copenhagenStart())
    }

    @Test("MoveNavigator clamps beyond max step")
    func clampBeyondMax() {
        let game = Game()
        let pos = MoveNavigator.position(at: 100, in: game)
        #expect(pos == game.position)
    }

    @Test("MoveNavigator player at step 0 is attacker")
    func playerAtZero() {
        let game = Game()
        let player = MoveNavigator.activePlayer(at: 0, in: game)
        #expect(player == .attacker)
    }

    @Test("MoveNavigator player alternates")
    func playerAlternates() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let player = MoveNavigator.activePlayer(at: 1, in: game)
        #expect(player == .defender)
    }

    @Test("MoveNavigator move at step")
    func moveAtStep() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let retrieved = MoveNavigator.move(at: 0, in: game)
        #expect(retrieved == move)
    }

    @Test("MoveNavigator move at invalid step returns nil")
    func moveAtInvalidStep() {
        let game = Game()
        let retrieved = MoveNavigator.move(at: 5, in: game)
        #expect(retrieved == nil)
    }

    @Test("MoveNavigator step count for new game is 1")
    func newGameStepCount() {
        let game = Game()
        #expect(MoveNavigator.stepCount(game: game) == 1)
    }
}
