import Testing
@testable import Hnefatafl

@Suite("Position Serialization Tests")
struct PositionSerializationTests {

    @Test("serialize empty board")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let serialized = PositionSerializer.serialize(position: position)
        #expect(!serialized.isEmpty)
    }

    @Test("deserialize roundtrip")
    func roundtrip() {
        let position = Position.copenhagenStart()
        let serialized = PositionSerializer.serialize(position: position)
        let deserialized = PositionSerializer.deserialize(serialized)
        #expect(deserialized == position)
    }

    @Test("serialize starting position is deterministic")
    func deterministic() {
        let position = Position.copenhagenStart()
        let a = PositionSerializer.serialize(position: position)
        let b = PositionSerializer.serialize(position: position)
        #expect(a == b)
    }

    @Test("empty board serialization roundtrips")
    func emptyRoundtrip() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let serialized = PositionSerializer.serialize(position: position)
        let deserialized = PositionSerializer.deserialize(serialized)
        #expect(deserialized == position)
    }

    @Test("deserialize invalid string returns nil")
    func invalidString() {
        let result = PositionSerializer.deserialize("invalid")
        #expect(result == nil)
    }

    @Test("serialized format uses compact encoding")
    func compactEncoding() {
        let position = Position.copenhagenStart()
        let serialized = PositionSerializer.serialize(position: position)
        #expect(serialized.count < 200)
    }

    @Test("single piece roundtrips")
    func singlePiece() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        let position = Position(cells: cells)
        let serialized = PositionSerializer.serialize(position: position)
        let deserialized = PositionSerializer.deserialize(serialized)
        #expect(deserialized == position)
    }

    @Test("all piece types roundtrip")
    func allPieceTypes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .defender
        cells[2] = .king
        let position = Position(cells: cells)
        let serialized = PositionSerializer.serialize(position: position)
        let deserialized = PositionSerializer.deserialize(serialized)
        #expect(deserialized == position)
    }
}
