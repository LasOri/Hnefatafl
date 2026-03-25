import Testing
@testable import Hnefatafl

@Suite("GameOverDisplay Tests")
struct GameOverDisplayTests {

    @Test("in-progress returns nil")
    func inProgressReturnsNil() {
        let game = Game()
        let data = GameOverDisplay.data(for: game)
        #expect(data == nil)
    }

    @Test("attacker win message")
    func attackerWinMessage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        if game.status == .attackerWins {
            let data = GameOverDisplay.data(for: game)
            #expect(data != nil)
            #expect(data!.message == "Attackers Win!")
        }
    }

    @Test("defender win message with king at corner")
    func defenderWinMessage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        if game.status == .defenderWins {
            let data = GameOverDisplay.data(for: game)
            #expect(data != nil)
            #expect(data!.message == "Defenders Win!")
        }
    }

    @Test("draw message")
    func drawMessage() {
        let data = GameOverData(status: .draw, message: "Draw!", moveCount: 200)
        #expect(data.message == "Draw!")
        #expect(data.status == .draw)
    }

    @Test("move count included")
    func moveCountIncluded() {
        let data = GameOverData(status: .attackerWins, message: "Attackers Win!", moveCount: 42)
        #expect(data.moveCount == 42)
    }
}
