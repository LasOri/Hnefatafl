import Testing
@testable import Hnefatafl

@Suite("GameRewindPoint Tests")
struct GameRewindPointTests {

    @Test("creates from new game")
    func fromNewGame() {
        let game = Game()
        let point = GameRewindPoint.from(game: game)
        #expect(point.currentPlayer == .attacker)
        #expect(point.moveIndex == 0)
    }

    @Test("position matches game position")
    func positionMatches() {
        let game = Game()
        let point = GameRewindPoint.from(game: game)
        #expect(point.position == game.position)
    }

    @Test("move index increments after move")
    func moveIndexIncrements() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let game2 = game.makeMove(move)
        let point = GameRewindPoint.from(game: game2)
        #expect(point.moveIndex == 1)
    }

    @Test("current player alternates")
    func playerAlternates() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let game2 = game.makeMove(move)
        let point = GameRewindPoint.from(game: game2)
        #expect(point.currentPlayer == .defender)
    }

    @Test("equatable conformance")
    func equatable() {
        let game = Game()
        let a = GameRewindPoint.from(game: game)
        let b = GameRewindPoint.from(game: game)
        #expect(a == b)
    }

    @Test("different positions are not equal")
    func differentPositions() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let game2 = game.makeMove(move)
        let a = GameRewindPoint.from(game: game)
        let b = GameRewindPoint.from(game: game2)
        #expect(a != b)
    }
}
