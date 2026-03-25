import Testing
import Foundation
@testable import Hnefatafl

@Suite("GameSession Tests")
struct GameSessionTests {
    @Test("Creates game session")
    func createSession() {
        let session = GameSession(id: "game-123", startTime: 1000.0, players: ("Alice", "Bob"))
        #expect(session.id == "game-123")
        #expect(session.startTime == 1000.0)
        #expect(session.players.0 == "Alice")
        #expect(session.players.1 == "Bob")
    }

    @Test("Session is active initially")
    func isActiveInitially() {
        let session = GameSession(id: "game-1", startTime: 0.0, players: ("P1", "P2"))
        #expect(session.isActive == true)
    }

    @Test("Calculates elapsed time")
    func elapsed() {
        let session = GameSession(id: "game-1", startTime: 100.0, players: ("P1", "P2"))
        let elapsed = session.elapsed(currentTime: 150.0)
        #expect(elapsed == 50.0)
    }

    @Test("Ends session")
    func endSession() {
        var session = GameSession(id: "game-1", startTime: 0.0, players: ("P1", "P2"))
        session.end()
        #expect(session.isActive == false)
    }

    @Test("Elapsed time after end")
    func elapsedAfterEnd() {
        var session = GameSession(id: "game-1", startTime: 100.0, players: ("P1", "P2"))
        session.end(at: 200.0)
        let elapsed = session.elapsed(currentTime: 300.0)
        #expect(elapsed == 100.0)
    }

    @Test("Session equality")
    func sessionEquality() {
        let session1 = GameSession(id: "game-1", startTime: 100.0, players: ("A", "B"))
        let session2 = GameSession(id: "game-1", startTime: 100.0, players: ("A", "B"))
        #expect(session1 == session2)
    }
}
