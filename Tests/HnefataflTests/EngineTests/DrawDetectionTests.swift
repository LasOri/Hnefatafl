import Testing
@testable import Hnefatafl

@Suite("Draw Detection Tests")
struct DrawDetectionTests {

    @Test("threefold repetition returns draw")
    func threefoldRepetitionDraw() {
        let game = Game()
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let move2 = Move(fromRow: 3, fromCol: 5, toRow: 2, toCol: 5)
        let g1 = game.makeMove(move1).makeMove(move2)
        let back1 = Move(fromRow: 2, fromCol: 3, toRow: 0, toCol: 3)
        let back2 = Move(fromRow: 2, fromCol: 5, toRow: 3, toCol: 5)
        let g2 = g1.makeMove(back1).makeMove(back2)
        let g3 = g2.makeMove(move1).makeMove(move2)
        let g4 = g3.makeMove(back1).makeMove(back2)
        #expect(g4.status == .draw)
    }

    @Test("no attackers means immediate defender wins")
    func noAttackersDefenderWins() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        #expect(game.status == .defenderWins)
    }

    @Test("lone king with no attackers is defender wins")
    func loneKingDefenderWins() {
        let position = emptyBoard()
            .placing(.king, row: 3, col: 3)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        #expect(game.status == .defenderWins)
    }

    @Test("move limit at 200 half-moves returns draw")
    func moveLimitDraw() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let moves = Array(repeating: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 0), count: 200)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: moves)
        #expect(game.status == .draw)
    }

    @Test("move limit at 199 half-moves still in progress")
    func underMoveLimitInProgress() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let moves = Array(repeating: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 0), count: 199)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: moves)
        #expect(game.status == .inProgress)
    }

    @Test("move limit not applied when game already won")
    func moveLimitNotAppliedWhenWon() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let moves = Array(repeating: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 0), count: 300)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: moves)
        #expect(game.status == .defenderWins)
    }

    @Test("attackerCount returns correct count")
    func attackerCountCorrect() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 1, col: 1)
            .placing(.defender, row: 2, col: 2)
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(position.attackerCount == 2)
    }

    @Test("defenderCount includes king")
    func defenderCountIncludesKing() {
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 0)
            .placing(.defender, row: 1, col: 1)
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(position.defenderCount == 3)
    }

    @Test("attackerCount is zero with no attackers")
    func noAttackersZeroCount() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(position.attackerCount == 0)
    }

    @Test("threefold takes precedence over move limit")
    func threefoldPrecedenceOverMoveLimit() {
        let position = Position.copenhagenStart()
        let history = [position, position, position]
        let moves = Array(repeating: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 0), count: 250)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: moves, positionHistory: history)
        #expect(game.status == .draw)
    }
}
