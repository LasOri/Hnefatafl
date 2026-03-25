import Testing
import Foundation
@testable import Hnefatafl

@Suite("GameStateSnapshot Tests")
struct GameStateSnapshotTests {
    @Test("Captures snapshot from game state")
    func captureSnapshot() {
        let state = GameState()
        let snapshot = GameStateSnapshot.capture(from: state)
        #expect(snapshot.moveNumber == 0)
    }

    @Test("Snapshot includes timestamp")
    func snapshotTimestamp() {
        let state = GameState()
        let snapshot = GameStateSnapshot.capture(from: state)
        #expect(snapshot.timestamp > 0)
    }

    @Test("Snapshot captures current player")
    func capturesPlayer() {
        let state = GameState()
        let snapshot = GameStateSnapshot.capture(from: state)
        #expect(snapshot.currentPlayer == .attacker)
    }

    @Test("Snapshot captures position data")
    func capturesPosition() {
        let state = GameState()
        let snapshot = GameStateSnapshot.capture(from: state)
        #expect(!snapshot.positionData.isEmpty)
    }

    @Test("Snapshot equality")
    func snapshotEquality() {
        let state = GameState()
        let snapshot1 = GameStateSnapshot.capture(from: state, at: 1000.0)
        let snapshot2 = GameStateSnapshot.capture(from: state, at: 1000.0)
        #expect(snapshot1 == snapshot2)
    }

    @Test("Multiple snapshots at different times")
    func multipleSnapshots() {
        let state = GameState()
        let snapshot1 = GameStateSnapshot.capture(from: state, at: 1000.0)
        let snapshot2 = GameStateSnapshot.capture(from: state, at: 2000.0)
        #expect(snapshot1.timestamp != snapshot2.timestamp)
    }
}
