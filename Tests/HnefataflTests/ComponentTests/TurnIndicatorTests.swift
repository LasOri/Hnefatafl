import Testing
@testable import Hnefatafl

@Suite("TurnIndicator Tests")
struct TurnIndicatorTests {

    @Test("initial game shows attacker")
    func initialGameAttacker() {
        let game = Game()
        let data = TurnIndicator.data(for: game)
        #expect(data.currentPlayer == .attacker)
    }

    @Test("move number starts at 1")
    func moveNumberStartsAtOne() {
        let game = Game()
        let data = TurnIndicator.data(for: game)
        #expect(data.moveNumber == 1)
    }

    @Test("label for attacker")
    func labelForAttacker() {
        let game = Game()
        let data = TurnIndicator.data(for: game)
        #expect(data.label == "Attacker's Turn")
    }

    @Test("label for defender after move")
    func labelForDefender() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let moved = game.makeMove(moves[0])
        let data = TurnIndicator.data(for: moved)
        #expect(data.label == "Defender's Turn")
    }

    @Test("move number increments")
    func moveNumberIncrements() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let moved = game.makeMove(moves[0])
        let data = TurnIndicator.data(for: moved)
        #expect(data.moveNumber == 2)
    }
}
