import Testing
@testable import Hnefatafl

@Suite("BoardOverviewData Tests")
struct BoardOverviewDataTests {
    @Test("Start position has correct piece counts")
    func startPositionCounts() {
        let position = Position.copenhagenStart()
        let data = BoardOverviewData.from(position: position, moveNumber: 0)
        #expect(data.attackerCount == 24)
        #expect(data.defenderCount == 13)
    }

    @Test("Total pieces equals attacker plus defender count")
    func totalPieces() {
        let data = BoardOverviewData(attackerCount: 10, defenderCount: 5, moveNumber: 1, phase: "Opening")
        #expect(data.totalPieces == 15)
    }

    @Test("Move number zero is opening phase")
    func openingPhase() {
        let position = Position.copenhagenStart()
        let data = BoardOverviewData.from(position: position, moveNumber: 5)
        #expect(data.phase == "Opening")
    }

    @Test("Move number 20 is midgame phase")
    func midgamePhase() {
        let position = Position.copenhagenStart()
        let data = BoardOverviewData.from(position: position, moveNumber: 20)
        #expect(data.phase == "Midgame")
    }

    @Test("Move number 50 is endgame phase")
    func endgamePhase() {
        let position = Position.copenhagenStart()
        let data = BoardOverviewData.from(position: position, moveNumber: 50)
        #expect(data.phase == "Endgame")
    }

    @Test("Equatable conformance works correctly")
    func equatable() {
        let a = BoardOverviewData(attackerCount: 10, defenderCount: 5, moveNumber: 1, phase: "Opening")
        let b = BoardOverviewData(attackerCount: 10, defenderCount: 5, moveNumber: 1, phase: "Opening")
        #expect(a == b)
    }
}
