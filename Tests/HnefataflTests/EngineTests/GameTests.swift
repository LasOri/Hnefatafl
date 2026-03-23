import Testing
@testable import Hnefatafl

@Suite("Game Tests")
struct GameTests {

    @Test("new game starts with attacker's turn")
    func newGame_attackerMovesFirst() {
        let game = Game()

        #expect(game.currentPlayer == .attacker)
    }

    @Test("after a move, turn switches to defender")
    func makeMove_switchesTurn() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let moved = game.makeMove(moves[0])

        #expect(moved.currentPlayer == .defender)
    }

    @Test("game tracks move history")
    func makeMove_appendsToHistory() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let moved = game.makeMove(moves[0])

        #expect(moved.moveHistory.count == 1)
    }

    @Test("game reports status from position")
    func status_newGame_inProgress() {
        let game = Game()

        #expect(game.status == .inProgress)
    }

    @Test("threefold repetition results in draw")
    func status_threefoldRepetition_draw() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 3)
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 10, col: 3)
            .build()
        var game = Game(position: position, currentPlayer: .attacker, moveHistory: [])

        let a1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let d1 = Move(fromRow: 10, fromCol: 3, toRow: 10, toCol: 4)
        let a2 = Move(fromRow: 0, fromCol: 4, toRow: 0, toCol: 3)
        let d2 = Move(fromRow: 10, fromCol: 4, toRow: 10, toCol: 3)

        game = game.makeMove(a1)
        game = game.makeMove(d1)
        game = game.makeMove(a2)
        game = game.makeMove(d2)
        game = game.makeMove(a1)
        game = game.makeMove(d1)
        game = game.makeMove(a2)
        game = game.makeMove(d2)

        #expect(game.status == .draw)
    }
}
