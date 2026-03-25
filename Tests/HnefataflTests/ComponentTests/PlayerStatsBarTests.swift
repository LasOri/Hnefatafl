import Testing
@testable import Hnefatafl

@Suite("PlayerStatsBar Tests")
struct PlayerStatsBarTests {

    @Test("starting position piece counts")
    func startingPieceCounts() {
        let position = Position.copenhagenStart()
        let attackerStats = PlayerStatsBar.stats(for: .attacker, position: position, initialPieceCount: position.attackerCount)
        let defenderStats = PlayerStatsBar.stats(for: .defender, position: position, initialPieceCount: position.defenderCount)
        #expect(attackerStats.pieceCount == position.attackerCount)
        #expect(defenderStats.pieceCount == position.defenderCount)
    }

    @Test("no captures initially")
    func noCapturesInitially() {
        let position = Position.copenhagenStart()
        let stats = PlayerStatsBar.stats(for: .attacker, position: position, initialPieceCount: position.attackerCount)
        #expect(stats.capturedCount == 0)
    }

    @Test("mobility greater than zero at start")
    func mobilityAtStart() {
        let position = Position.copenhagenStart()
        let stats = PlayerStatsBar.stats(for: .attacker, position: position, initialPieceCount: position.attackerCount)
        #expect(stats.mobilityScore > 0)
    }

    @Test("correct attacker stats")
    func correctAttackerStats() {
        let position = Position.copenhagenStart()
        let stats = PlayerStatsBar.stats(for: .attacker, position: position, initialPieceCount: 24)
        #expect(stats.pieceCount == position.attackerCount)
        #expect(stats.capturedCount == 24 - position.attackerCount)
    }

    @Test("correct defender stats")
    func correctDefenderStats() {
        let position = Position.copenhagenStart()
        let stats = PlayerStatsBar.stats(for: .defender, position: position, initialPieceCount: position.defenderCount)
        #expect(stats.capturedCount == 0)
        #expect(stats.mobilityScore > 0)
    }
}
