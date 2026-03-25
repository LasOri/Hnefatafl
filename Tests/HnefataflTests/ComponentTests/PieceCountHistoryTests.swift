import Testing
@testable import Hnefatafl

@Suite("PieceCountHistory Tests")
struct PieceCountHistoryTests {
    @Test("Creates snapshot with counts")
    func createSnapshot() {
        let snapshot = PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0)
        #expect(snapshot.attackers == 16)
        #expect(snapshot.defenders == 8)
        #expect(snapshot.moveNumber == 0)
    }

    @Test("Records snapshot in history")
    func recordSnapshot() {
        var history = PieceCountHistory()
        let snapshot = PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0)
        history.record(snapshot: snapshot)
        #expect(history.snapshots.count == 1)
        #expect(history.snapshots[0] == snapshot)
    }

    @Test("Tracks attacker trend decreasing")
    func attackerTrend() {
        var history = PieceCountHistory()
        history.record(snapshot: PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0))
        history.record(snapshot: PieceCountSnapshot(attackers: 14, defenders: 8, moveNumber: 1))
        #expect(history.attackerTrend == -2)
    }

    @Test("Tracks defender trend decreasing")
    func defenderTrend() {
        var history = PieceCountHistory()
        history.record(snapshot: PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0))
        history.record(snapshot: PieceCountSnapshot(attackers: 16, defenders: 6, moveNumber: 1))
        #expect(history.defenderTrend == -2)
    }

    @Test("Returns zero trend with single snapshot")
    func singleSnapshotTrend() {
        var history = PieceCountHistory()
        history.record(snapshot: PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0))
        #expect(history.attackerTrend == 0)
        #expect(history.defenderTrend == 0)
    }

    @Test("Returns zero trend with empty history")
    func emptyHistoryTrend() {
        let history = PieceCountHistory()
        #expect(history.attackerTrend == 0)
        #expect(history.defenderTrend == 0)
    }

    @Test("Tracks multiple snapshots")
    func multipleSnapshots() {
        var history = PieceCountHistory()
        history.record(snapshot: PieceCountSnapshot(attackers: 16, defenders: 8, moveNumber: 0))
        history.record(snapshot: PieceCountSnapshot(attackers: 15, defenders: 7, moveNumber: 1))
        history.record(snapshot: PieceCountSnapshot(attackers: 14, defenders: 7, moveNumber: 2))
        #expect(history.snapshots.count == 3)
        #expect(history.attackerTrend == -2)
        #expect(history.defenderTrend == -1)
    }
}
