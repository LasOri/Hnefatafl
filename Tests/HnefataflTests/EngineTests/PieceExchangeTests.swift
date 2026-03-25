import Testing
@testable import Hnefatafl

@Suite("Piece Exchange Tests")
struct PieceExchangeTests {

    @Test("empty board returns zero balance")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceExchange.exchangeBalance(position: pos, player: .attacker) == 0)
    }

    @Test("no captures means zero balance")
    func noCapturesZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(PieceExchange.exchangeBalance(position: pos, player: .attacker) == 0)
    }

    @Test("hasWinningExchange false when no captures")
    func noWinningExchange() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(!PieceExchange.hasWinningExchange(position: pos, player: .attacker))
    }

    @Test("start position balance is non-negative")
    func startPositionNonNegative() {
        let pos = Position.copenhagenStart()
        #expect(PieceExchange.exchangeBalance(position: pos, player: .attacker) >= 0)
        #expect(PieceExchange.exchangeBalance(position: pos, player: .defender) >= 0)
    }

    @Test("hasWinningExchange consistent with balance")
    func winningExchangeConsistent() {
        let pos = Position.copenhagenStart()
        let balance = PieceExchange.exchangeBalance(position: pos, player: .attacker)
        let hasWinning = PieceExchange.hasWinningExchange(position: pos, player: .attacker)
        #expect(hasWinning == (balance > 0))
    }

    @Test("defender balance also works")
    func defenderBalance() {
        let pos = Position.copenhagenStart()
        let balance = PieceExchange.exchangeBalance(position: pos, player: .defender)
        #expect(balance >= 0)
    }
}
