import Testing
@testable import Hnefatafl

@Suite("UtilityIntegration Tests")
struct UtilityIntegrationTests {

    @Test("Initialize completes without crashing on Copenhagen start for attacker")
    func initializeCopenhagenAttacker() {
        let pos = Position.copenhagenStart()
        UtilityIntegration.initialize(position: pos, player: .attacker)
        // If we reach here, it did not crash
        #expect(true)
    }

    @Test("Initialize completes without crashing on Copenhagen start for defender")
    func initializeCopenhagenDefender() {
        let pos = Position.copenhagenStart()
        UtilityIntegration.initialize(position: pos, player: .defender)
        #expect(true)
    }

    @Test("Initialize completes on minimal board with king and one attacker")
    func initializeMinimalBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        UtilityIntegration.initialize(position: pos, player: .attacker)
        #expect(true)
    }

    @Test("Initialize completes on board with king near corner")
    func initializeKingNearCorner() {
        let pos = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .build()
        UtilityIntegration.initialize(position: pos, player: .defender)
        #expect(true)
    }

    @Test("Initialize completes on board with many pieces")
    func initializeDenseBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 6)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 10, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .placing(.attacker, row: 5, col: 10)
            .build()
        UtilityIntegration.initialize(position: pos, player: .attacker)
        #expect(true)
    }
}
