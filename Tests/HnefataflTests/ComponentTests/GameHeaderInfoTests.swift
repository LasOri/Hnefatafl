import Testing
@testable import Hnefatafl

@Suite("Game Header Info Tests")
struct GameHeaderInfoTests {

    @Test("status text for attacker turn")
    func attackerTurn() {
        let info = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 5, gameStatus: .inProgress)
        #expect(info.statusText == "Attacker's Turn - Move 5")
    }

    @Test("status text for defender turn")
    func defenderTurn() {
        let info = GameHeaderInfo(currentPlayer: .defender, moveNumber: 10, gameStatus: .inProgress)
        #expect(info.statusText == "Defender's Turn - Move 10")
    }

    @Test("status text for attacker wins")
    func attackerWins() {
        let info = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 30, gameStatus: .attackerWins)
        #expect(info.statusText == "Attackers Win!")
    }

    @Test("status text for draw")
    func drawStatus() {
        let info = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 200, gameStatus: .draw)
        #expect(info.statusText == "Game Drawn")
    }

    @Test("is game over when attacker wins")
    func gameOverAttacker() {
        let info = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 25, gameStatus: .attackerWins)
        #expect(info.isGameOver == true)
    }

    @Test("is not game over when in progress")
    func notGameOver() {
        let info = GameHeaderInfo(currentPlayer: .defender, moveNumber: 5, gameStatus: .inProgress)
        #expect(info.isGameOver == false)
    }

    @Test("equatable compares all fields")
    func equatable() {
        let a = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 1, gameStatus: .inProgress)
        let b = GameHeaderInfo(currentPlayer: .attacker, moveNumber: 1, gameStatus: .inProgress)
        #expect(a == b)
    }
}
