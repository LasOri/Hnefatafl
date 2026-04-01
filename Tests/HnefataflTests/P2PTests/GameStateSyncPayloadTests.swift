import Testing
import LINKER
@testable import Hnefatafl

@Suite("GameStateSyncPayload Tests")
struct GameStateSyncPayloadTests {

    @Test("toJson includes all fields")
    func toJson_includesFields() {
        let payload = GameStateSyncPayload(
            cells: ["attacker", nil, "king"],
            currentPlayer: "attacker",
            moveHistory: [[0, 3, 0, 5]],
            variant: "copenhagen"
        )
        let json = payload.toJson()
        #expect(json["currentPlayer"]?.stringValue == "attacker")
        #expect(json["variant"]?.stringValue == "copenhagen")
    }

    @Test("fromJson round-trips with toJson")
    func fromJson_roundTrips() {
        let original = GameStateSyncPayload(
            cells: ["attacker", "defender", nil, "king"],
            currentPlayer: "defender",
            moveHistory: [[0, 3, 0, 5], [5, 5, 0, 5]],
            variant: "tablut"
        )
        let json = original.toJson()
        let recovered = GameStateSyncPayload.fromJson(json)
        #expect(recovered == original)
    }

    @Test("fromJson returns nil for missing fields")
    func fromJson_missingFields() {
        #expect(GameStateSyncPayload.fromJson(.null) == nil)
        #expect(GameStateSyncPayload.fromJson(.object([:])) == nil)
    }

    @Test("cells preserve nil values")
    func cells_preserveNils() {
        let payload = GameStateSyncPayload(
            cells: [nil, "attacker", nil],
            currentPlayer: "attacker",
            moveHistory: [],
            variant: "copenhagen"
        )
        let json = payload.toJson()
        let recovered = GameStateSyncPayload.fromJson(json)
        #expect(recovered?.cells[0] == nil)
        #expect(recovered?.cells[1] == "attacker")
        #expect(recovered?.cells[2] == nil)
    }

    @Test("empty moveHistory round-trips")
    func emptyMoveHistory_roundTrips() {
        let payload = GameStateSyncPayload(
            cells: [],
            currentPlayer: "attacker",
            moveHistory: [],
            variant: "copenhagen"
        )
        let json = payload.toJson()
        let recovered = GameStateSyncPayload.fromJson(json)
        #expect(recovered?.moveHistory.isEmpty == true)
    }

    @Test("equality works correctly")
    func equality() {
        let a = GameStateSyncPayload(cells: ["king"], currentPlayer: "defender", moveHistory: [], variant: "copenhagen")
        let b = GameStateSyncPayload(cells: ["king"], currentPlayer: "defender", moveHistory: [], variant: "copenhagen")
        let c = GameStateSyncPayload(cells: ["king"], currentPlayer: "attacker", moveHistory: [], variant: "copenhagen")
        #expect(a == b)
        #expect(a != c)
    }
}
