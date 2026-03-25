import Testing
@testable import Hnefatafl

@Suite("WeaknessProbe Tests")
struct WeaknessProbeTests {
    @Test("Empty board has no weaknesses")
    func emptyBoardNoWeaknesses() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let count = WeaknessProbe.weaknesses(position: position, player: .attacker)
        #expect(count == 0)
    }

    @Test("Isolated piece with no enemy is not weak")
    func isolatedNotWeak() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let count = WeaknessProbe.weaknesses(position: position, player: .attacker)
        #expect(count == 0)
    }

    @Test("Piece next to enemy with no ally is weak")
    func pieceNextToEnemyIsWeak() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .build()
        let count = WeaknessProbe.weaknesses(position: position, player: .attacker)
        #expect(count == 1)
    }

    @Test("Critical weakness on empty board for defender is true (no king)")
    func noKingCritical() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let critical = WeaknessProbe.criticalWeakness(position: position, player: .defender)
        #expect(critical)
    }

    @Test("King surrounded by 3 attackers is critical weakness")
    func kingSurroundedCritical() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .build()
        let critical = WeaknessProbe.criticalWeakness(position: position, player: .defender)
        #expect(critical)
    }

    @Test("Lone king without surrounding attackers is not critical")
    func loneKingNotCritical() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let critical = WeaknessProbe.criticalWeakness(position: position, player: .defender)
        #expect(!critical)
    }
}
