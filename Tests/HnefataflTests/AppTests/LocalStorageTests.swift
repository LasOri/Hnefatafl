import Testing
@testable import Hnefatafl

@Suite("Local Storage Tests")
struct LocalStorageTests {

    @Test("SaveData stores game state fields")
    func storeFields() {
        let data = SaveData(positionString: "...", moveCount: 5, currentPlayer: .attacker, muted: false, aiDifficulty: .medium)
        #expect(data.moveCount == 5)
        #expect(data.currentPlayer == .attacker)
    }

    @Test("SaveData is Equatable")
    func equatable() {
        let a = SaveData(positionString: "abc", moveCount: 3, currentPlayer: .defender, muted: true, aiDifficulty: .easy)
        let b = SaveData(positionString: "abc", moveCount: 3, currentPlayer: .defender, muted: true, aiDifficulty: .easy)
        #expect(a == b)
    }

    @Test("SaveEncoder produces JSON string")
    func encodesJSON() {
        let data = SaveData(positionString: "test", moveCount: 0, currentPlayer: .attacker, muted: false, aiDifficulty: .medium)
        let json = SaveEncoder.encode(data)
        #expect(json.contains("test"))
        #expect(json.contains("moveCount"))
    }

    @Test("SaveEncoder roundtrip")
    func roundtrip() {
        let original = SaveData(positionString: "ABC", moveCount: 10, currentPlayer: .defender, muted: true, aiDifficulty: .hard)
        let json = SaveEncoder.encode(original)
        let decoded = SaveEncoder.decode(json)
        #expect(decoded == original)
    }

    @Test("decode invalid JSON returns nil")
    func invalidJSON() {
        let result = SaveEncoder.decode("not json")
        #expect(result == nil)
    }

    @Test("SaveData from GameState")
    func fromGameState() {
        let state = GameState()
        let data = SaveData.from(state: state)
        #expect(data.currentPlayer == .attacker)
        #expect(data.moveCount == 0)
    }

    @Test("storage key is consistent")
    func storageKey() {
        #expect(SaveEncoder.storageKey == "hnefatafl-save")
    }

    @Test("encode handles special characters in position")
    func specialChars() {
        let data = SaveData(positionString: "A.D.K.", moveCount: 1, currentPlayer: .attacker, muted: false, aiDifficulty: .easy)
        let json = SaveEncoder.encode(data)
        let decoded = SaveEncoder.decode(json)
        #expect(decoded?.positionString == "A.D.K.")
    }
}
