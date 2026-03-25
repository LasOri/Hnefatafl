import Testing
@testable import Hnefatafl

@Suite("Opening Move Database Tests")
struct OpeningMoveDatabaseTests {

    @Test("database has entries")
    func hasEntries() {
        #expect(OpeningMoveDatabase.count == 3)
    }

    @Test("find by name returns correct entry")
    func findByName() {
        let entry = OpeningMoveDatabase.find(name: "Center Attack")
        #expect(entry != nil)
        #expect(entry?.firstMove == Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5))
    }

    @Test("find unknown name returns nil")
    func findUnknownReturnsNil() {
        let entry = OpeningMoveDatabase.find(name: "Nonexistent")
        #expect(entry == nil)
    }

    @Test("entries have no responses yet")
    func noResponses() {
        for entry in OpeningMoveDatabase.entries {
            #expect(entry.response == nil)
        }
    }

    @Test("entry equality")
    func entryEquality() {
        let a = OpeningMoveEntry(name: "Test", firstMove: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0), response: nil)
        let b = OpeningMoveEntry(name: "Test", firstMove: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0), response: nil)
        #expect(a == b)
    }
}
