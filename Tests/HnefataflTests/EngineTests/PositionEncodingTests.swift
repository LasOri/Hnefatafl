import Testing
@testable import Hnefatafl

@Suite("PositionEncoding Tests")
struct PositionEncodingTests {

    @Test("encode empty board")
    func encodeEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let encoded = PositionEncoding.encode(position)
        #expect(!encoded.isEmpty)
    }

    @Test("decode empty board back")
    func decodeEmpty() {
        let original = Position(cells: Array(repeating: nil, count: 121))
        let encoded = PositionEncoding.encode(original)
        let decoded = PositionEncoding.decode(encoded)
        #expect(decoded == original)
    }

    @Test("encode starting position")
    func encodeStart() {
        let position = Position.copenhagenStart()
        let encoded = PositionEncoding.encode(position)
        #expect(!encoded.isEmpty)
        #expect(encoded.count < 200)
    }

    @Test("round trip starting position")
    func roundTripStart() {
        let original = Position.copenhagenStart()
        let encoded = PositionEncoding.encode(original)
        let decoded = PositionEncoding.decode(encoded)
        #expect(decoded == original)
    }

    @Test("encoding contains piece markers")
    func containsPieceMarkers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .defender
        cells[2] = .king
        let position = Position(cells: cells)
        let encoded = PositionEncoding.encode(position)
        #expect(encoded.contains("A"))
        #expect(encoded.contains("D"))
        #expect(encoded.contains("K"))
    }

    @Test("decode invalid string returns nil")
    func decodeInvalid() {
        #expect(PositionEncoding.decode("") == nil)
        #expect(PositionEncoding.decode("xyz") == nil)
    }

    @Test("round trip position with few pieces")
    func roundTripFewPieces() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[60] = .attacker
        cells[120] = .defender
        let original = Position(cells: cells)
        let encoded = PositionEncoding.encode(original)
        let decoded = PositionEncoding.decode(encoded)
        #expect(decoded == original)
    }

    @Test("encoding uses run-length for empty squares")
    func runLengthEncoding() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let encoded = PositionEncoding.encode(position)
        #expect(encoded.count < 40)
    }
}
