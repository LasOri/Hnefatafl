import Testing
@testable import Hnefatafl

@Suite("GameStateSummary Tests")
struct GameStateSummaryTests {
    @Test("Active game is game active")
    func activeGame() {
        let summary = GameStateSummary(
            attackerCount: 16,
            defenderCount: 9,
            currentPlayer: .attacker,
            moveNumber: 1,
            status: .inProgress
        )
        #expect(summary.isGameActive == true)
    }

    @Test("Finished game is not active")
    func finishedGame() {
        let summary = GameStateSummary(
            attackerCount: 16,
            defenderCount: 0,
            currentPlayer: .attacker,
            moveNumber: 30,
            status: .attackerWins
        )
        #expect(summary.isGameActive == false)
    }

    @Test("Material advantage for attackers")
    func attackerAdvantage() {
        let summary = GameStateSummary(
            attackerCount: 12,
            defenderCount: 5,
            currentPlayer: .defender,
            moveNumber: 10,
            status: .inProgress
        )
        #expect(summary.materialAdvantage == "Attackers +7")
    }

    @Test("Material advantage for defenders")
    func defenderAdvantage() {
        let summary = GameStateSummary(
            attackerCount: 5,
            defenderCount: 8,
            currentPlayer: .attacker,
            moveNumber: 15,
            status: .inProgress
        )
        #expect(summary.materialAdvantage == "Defenders +3")
    }

    @Test("Even material")
    func evenMaterial() {
        let summary = GameStateSummary(
            attackerCount: 8,
            defenderCount: 8,
            currentPlayer: .attacker,
            moveNumber: 20,
            status: .inProgress
        )
        #expect(summary.materialAdvantage == "Even")
    }

    @Test("Draw status is not active")
    func drawNotActive() {
        let summary = GameStateSummary(
            attackerCount: 8,
            defenderCount: 8,
            currentPlayer: .attacker,
            moveNumber: 50,
            status: .draw
        )
        #expect(summary.isGameActive == false)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = GameStateSummary(attackerCount: 16, defenderCount: 9, currentPlayer: .attacker, moveNumber: 1, status: .inProgress)
        let b = GameStateSummary(attackerCount: 16, defenderCount: 9, currentPlayer: .attacker, moveNumber: 1, status: .inProgress)
        let c = GameStateSummary(attackerCount: 15, defenderCount: 9, currentPlayer: .attacker, moveNumber: 1, status: .inProgress)
        #expect(a == b)
        #expect(a != c)
    }
}
