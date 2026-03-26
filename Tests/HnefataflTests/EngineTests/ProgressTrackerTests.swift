import Testing
@testable import Hnefatafl

@Suite("ProgressTracker Tests")
struct ProgressTrackerTests {

    @Test("starting position has initial progress")
    func startProgress() {
        let game = Game()
        let progress = ProgressTracker.evaluate(game: game)
        #expect(progress.attackerProgress >= 0)
        #expect(progress.defenderProgress >= 0)
    }

    @Test("progress values are percentages")
    func percentages() {
        let game = Game()
        let progress = ProgressTracker.evaluate(game: game)
        #expect(progress.attackerProgress >= 0 && progress.attackerProgress <= 100)
        #expect(progress.defenderProgress >= 0 && progress.defenderProgress <= 100)
    }

    @Test("ProgressResult is Equatable")
    func equatable() {
        let a = ProgressResult(attackerProgress: 50, defenderProgress: 30)
        let b = ProgressResult(attackerProgress: 50, defenderProgress: 30)
        #expect(a == b)
    }

    @Test("king near corner increases defender progress")
    func kingNearCorner() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .build()
        let game = Game(position: pos, currentPlayer: .defender, moveHistory: [])
        let progress = ProgressTracker.evaluate(game: game)
        #expect(progress.defenderProgress > 50)
    }

    @Test("few defenders increases attacker progress")
    func fewDefenders() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 3)
            .place(.attacker, row: 0, col: 4)
            .place(.attacker, row: 0, col: 5)
            .place(.attacker, row: 0, col: 6)
            .place(.attacker, row: 0, col: 7)
            .place(.king, row: 5, col: 5)
            .build()
        let game = Game(position: pos, currentPlayer: .attacker, moveHistory: [])
        let progress = ProgressTracker.evaluate(game: game)
        #expect(progress.attackerProgress > 0)
    }

    @Test("progress after a move changes")
    func afterMove() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let progress = ProgressTracker.evaluate(game: game)
        #expect(progress.attackerProgress >= 0)
    }
}
