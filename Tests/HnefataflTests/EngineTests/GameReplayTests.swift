import Testing
@testable import Hnefatafl

@Suite("GameReplay Tests")
struct GameReplayTests {

    @Test("replay starts at move 0")
    func startsAtZero() {
        let game = Game()
        let replay = GameReplay(game: game)
        #expect(replay.currentMoveIndex == 0)
    }

    @Test("forward advances index")
    func forward() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        var replay = GameReplay(game: game)
        replay.forward()
        #expect(replay.currentMoveIndex == 1)
    }

    @Test("backward decrements index")
    func backward() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        var replay = GameReplay(game: game)
        replay.forward()
        replay.backward()
        #expect(replay.currentMoveIndex == 0)
    }

    @Test("cannot go backward past zero")
    func backwardLimit() {
        let game = Game()
        var replay = GameReplay(game: game)
        replay.backward()
        #expect(replay.currentMoveIndex == 0)
    }

    @Test("cannot go forward past end")
    func forwardLimit() {
        let game = Game()
        var replay = GameReplay(game: game)
        replay.forward()
        #expect(replay.currentMoveIndex == 0)
    }

    @Test("currentPosition returns position at index")
    func currentPosition() {
        let game = Game()
        let replay = GameReplay(game: game)
        #expect(replay.currentPosition == Position.copenhagenStart())
    }

    @Test("isAtEnd reports correctly")
    func isAtEnd() {
        let game = Game()
        let replay = GameReplay(game: game)
        #expect(replay.isAtEnd)
    }

    @Test("isAtStart reports correctly")
    func isAtStart() {
        let game = Game()
        let replay = GameReplay(game: game)
        #expect(replay.isAtStart)
    }
}
