import Testing
@testable import Hnefatafl

@Suite("GameSessionInfo Tests")
struct GameSessionInfoTests {
    @Test("Completed session status text includes Completed")
    func completedStatusText() {
        let session = GameSessionInfo(sessionId: 1, startDate: "2026-03-25", movesMade: 42, isComplete: true)
        #expect(session.statusText == "Completed (42 moves)")
    }

    @Test("In progress session status text")
    func inProgressStatusText() {
        let session = GameSessionInfo(sessionId: 2, startDate: "2026-03-25", movesMade: 10, isComplete: false)
        #expect(session.statusText == "In progress (10 moves)")
    }

    @Test("Zero moves shows correct count")
    func zeroMoves() {
        let session = GameSessionInfo(sessionId: 3, startDate: "2026-03-25", movesMade: 0, isComplete: false)
        #expect(session.statusText == "In progress (0 moves)")
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = GameSessionInfo(sessionId: 1, startDate: "2026-03-25", movesMade: 5, isComplete: false)
        let b = GameSessionInfo(sessionId: 1, startDate: "2026-03-25", movesMade: 5, isComplete: false)
        #expect(a == b)
    }

    @Test("Different session IDs are not equal")
    func notEqual() {
        let a = GameSessionInfo(sessionId: 1, startDate: "2026-03-25", movesMade: 5, isComplete: false)
        let b = GameSessionInfo(sessionId: 2, startDate: "2026-03-25", movesMade: 5, isComplete: false)
        #expect(a != b)
    }

    @Test("Session stores all properties")
    func storesProperties() {
        let session = GameSessionInfo(sessionId: 99, startDate: "2026-01-01", movesMade: 100, isComplete: true)
        #expect(session.sessionId == 99)
        #expect(session.startDate == "2026-01-01")
        #expect(session.movesMade == 100)
        #expect(session.isComplete == true)
    }
}
