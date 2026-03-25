import Testing
@testable import Hnefatafl

@Suite("GameSnapshot Tests")
struct GameSnapshotTests {
    @Test("Capture from start position")
    func captureStart() {
        let position = Position.copenhagenStart()
        let snapshot = GameSnapshot.capture(position: position, moveNumber: 0)
        #expect(snapshot.attackerCount == position.attackerCount)
        #expect(snapshot.defenderCount == position.defenderCount)
        #expect(snapshot.hasKing == true)
        #expect(snapshot.moveNumber == 0)
    }

    @Test("Has king is true when king present")
    func hasKingTrue() {
        let snapshot = GameSnapshot(attackerCount: 24, defenderCount: 13, kingRow: 5, kingCol: 5, moveNumber: 10)
        #expect(snapshot.hasKing == true)
    }

    @Test("Has king is false when king absent")
    func hasKingFalse() {
        let snapshot = GameSnapshot(attackerCount: 24, defenderCount: 12, kingRow: nil, kingCol: nil, moveNumber: 10)
        #expect(snapshot.hasKing == false)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = GameSnapshot(attackerCount: 24, defenderCount: 13, kingRow: 5, kingCol: 5, moveNumber: 0)
        let b = GameSnapshot(attackerCount: 24, defenderCount: 13, kingRow: 5, kingCol: 5, moveNumber: 0)
        #expect(a == b)
    }

    @Test("Different snapshots are not equal")
    func notEqual() {
        let a = GameSnapshot(attackerCount: 24, defenderCount: 13, kingRow: 5, kingCol: 5, moveNumber: 0)
        let b = GameSnapshot(attackerCount: 23, defenderCount: 13, kingRow: 5, kingCol: 5, moveNumber: 1)
        #expect(a != b)
    }

    @Test("Capture from empty board has no king")
    func captureEmptyBoard() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let snapshot = GameSnapshot.capture(position: position, moveNumber: 5)
        #expect(snapshot.hasKing == false)
        #expect(snapshot.kingRow == nil)
        #expect(snapshot.kingCol == nil)
    }
}
