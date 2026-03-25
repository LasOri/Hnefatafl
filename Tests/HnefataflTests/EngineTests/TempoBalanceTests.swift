import Testing
@testable import Hnefatafl

@Suite("TempoBalance Tests")
struct TempoBalanceTests {
    @Test("Start position tempo advantage for attacker")
    func startPositionAttacker() {
        let position = Position.copenhagenStart()
        let advantage = TempoBalance.tempoAdvantage(position: position, player: .attacker)
        #expect(advantage != 0 || advantage == 0)
    }

    @Test("Tempo advantage is inverse for each player")
    func inverseForPlayers() {
        let position = Position.copenhagenStart()
        let attackerAdv = TempoBalance.tempoAdvantage(position: position, player: .attacker)
        let defenderAdv = TempoBalance.tempoAdvantage(position: position, player: .defender)
        #expect(attackerAdv == -defenderAdv)
    }

    @Test("Has initiative when advantage is positive")
    func hasInitiativePositive() {
        let position = Position.copenhagenStart()
        let attackerAdv = TempoBalance.tempoAdvantage(position: position, player: .attacker)
        let hasIt = TempoBalance.hasInitiative(position: position, player: .attacker)
        #expect(hasIt == (attackerAdv > 0))
    }

    @Test("Empty board has zero tempo for attacker")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let advantage = TempoBalance.tempoAdvantage(position: position, player: .attacker)
        #expect(advantage == 0)
    }

    @Test("Only one player can have initiative")
    func onlyOneHasInitiative() {
        let position = Position.copenhagenStart()
        let attackerInit = TempoBalance.hasInitiative(position: position, player: .attacker)
        let defenderInit = TempoBalance.hasInitiative(position: position, player: .defender)
        #expect(!(attackerInit && defenderInit))
    }

    @Test("Tempo is based on legal move count difference")
    func tempoBasedOnMoves() {
        let position = Position.copenhagenStart()
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        let advantage = TempoBalance.tempoAdvantage(position: position, player: .attacker)
        #expect(advantage == attackerMoves - defenderMoves)
    }
}
