import Testing
@testable import Hnefatafl

@Suite("Win Condition Tests")
struct WinConditionTests {

    @Test("defenders win when king reaches corner")
    func gameStatus_kingOnCorner_defenderWins() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()

        let status = Position.gameStatus(position)

        #expect(status == .defenderWins)
    }

    @Test("attackers win when king is captured")
    func gameStatus_noKingOnBoard_attackerWins() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .build()

        let status = Position.gameStatus(position)

        #expect(status == .attackerWins)
    }

    @Test("game in progress when king exists and not on corner")
    func gameStatus_kingInCenter_inProgress() {
        let position = Position.copenhagenStart()

        let status = Position.gameStatus(position)

        #expect(status == .inProgress)
    }
}
