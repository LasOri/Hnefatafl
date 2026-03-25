import Testing
@testable import Hnefatafl

@Suite("Piece Proximity Tests")
struct PieceProximityTests {

    @Test("nearest enemy returns manhattan distance")
    func nearestEnemyDistance() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 8)
            .build()
        let dist = PieceProximity.nearestEnemy(row: 5, col: 5, position: position, player: .defender)
        #expect(dist == 3)
    }

    @Test("nearest enemy returns zero when no enemies")
    func noEnemiesReturnsZero() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .build()
        let dist = PieceProximity.nearestEnemy(row: 5, col: 5, position: position, player: .defender)
        #expect(dist == 0)
    }

    @Test("average proximity computes correctly")
    func averageProximity() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let avg = PieceProximity.averageProximity(position: position, player: .defender)
        #expect(avg == 5.0)
    }

    @Test("average proximity for attacker")
    func averageProximityAttacker() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 8)
            .placing(.attacker, row: 5, col: 2)
            .build()
        let avg = PieceProximity.averageProximity(position: position, player: .attacker)
        #expect(avg == 3.0)
    }

    @Test("nearest enemy picks closest")
    func nearestEnemyPicksClosest() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 8)
            .placing(.attacker, row: 5, col: 3)
            .build()
        let dist = PieceProximity.nearestEnemy(row: 5, col: 5, position: position, player: .defender)
        #expect(dist == 2)
    }
}
