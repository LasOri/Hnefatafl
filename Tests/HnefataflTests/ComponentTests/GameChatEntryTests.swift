import Testing
@testable import Hnefatafl

@Suite("Game Chat Entry Tests")
struct GameChatEntryTests {

    @Test("formatted entry includes move number and sender")
    func formattedEntry() {
        let entry = GameChatEntry(sender: "Alice", message: "Good move!", moveNumber: 5)
        #expect(entry.formattedEntry == "[5] Alice: Good move!")
    }

    @Test("move number zero formats correctly")
    func moveNumberZero() {
        let entry = GameChatEntry(sender: "System", message: "Game started", moveNumber: 0)
        #expect(entry.formattedEntry == "[0] System: Game started")
    }

    @Test("equatable conformance with same values")
    func equatable() {
        let a = GameChatEntry(sender: "A", message: "hi", moveNumber: 1)
        let b = GameChatEntry(sender: "A", message: "hi", moveNumber: 1)
        #expect(a == b)
    }

    @Test("different messages are not equal")
    func notEqual() {
        let a = GameChatEntry(sender: "A", message: "hi", moveNumber: 1)
        let b = GameChatEntry(sender: "A", message: "bye", moveNumber: 1)
        #expect(a != b)
    }

    @Test("sender property stores correctly")
    func senderStored() {
        let entry = GameChatEntry(sender: "Bob", message: "test", moveNumber: 3)
        #expect(entry.sender == "Bob")
    }

    @Test("message property stores correctly")
    func messageStored() {
        let entry = GameChatEntry(sender: "X", message: "Hello world", moveNumber: 7)
        #expect(entry.message == "Hello world")
    }
}
