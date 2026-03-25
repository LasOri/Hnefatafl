import Testing
@testable import Hnefatafl

@Suite("Status Message Tests")
struct StatusMessageTests {

    @Test("in progress message is not urgent")
    func inProgressNotUrgent() {
        let game = Game()
        let msg = StatusMessage.forGame(game)
        #expect(msg.isUrgent == false)
    }

    @Test("attacker turn text contains Attacker")
    func attackerTurnText() {
        let game = Game()
        let msg = StatusMessage.forGame(game)
        #expect(msg.text.contains("Attacker"))
    }

    @Test("attacker wins message is urgent")
    func winMessageUrgent() {
        let game = Game(position: Position(cells: Array(repeating: nil, count: 121)), currentPlayer: .attacker, moveHistory: [])
        let msg = StatusMessage.forGame(game)
        #expect(msg.isUrgent == true)
    }

    @Test("draw message text contains drawn")
    func drawMessage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[Position.index(row: 2, col: 2)] = .king
        cells[Position.index(row: 8, col: 8)] = .attacker
        let position = Position(cells: cells)
        let moves = Array(repeating: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 0), count: 200)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: moves)
        let msg = StatusMessage.forGame(game)
        #expect(msg.text.contains("drawn"))
    }

    @Test("move number appears in in-progress text")
    func moveNumberInText() {
        let game = Game()
        let msg = StatusMessage.forGame(game)
        #expect(msg.text.contains("1"))
    }
}
