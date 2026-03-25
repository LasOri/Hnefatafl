import Testing
@testable import Hnefatafl

@Suite("Position Compressor Tests")
struct PositionCompressorTests {

    @Test("compressed size is less than 121 bytes")
    func compressedSizeLessThan121() {
        let position = Position.copenhagenStart()
        let size = PositionCompressor.compressedSize(position: position)
        #expect(size < 121)
    }

    @Test("empty board compresses")
    func emptyBoardCompresses() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let bytes = PositionCompressor.compress(position: position)
        #expect(!bytes.isEmpty)
    }

    @Test("start position compresses")
    func startPositionCompresses() {
        let position = Position.copenhagenStart()
        let bytes = PositionCompressor.compress(position: position)
        #expect(!bytes.isEmpty)
    }

    @Test("same position produces same bytes")
    func samePositionSameBytes() {
        let position = Position.copenhagenStart()
        let bytes1 = PositionCompressor.compress(position: position)
        let bytes2 = PositionCompressor.compress(position: position)
        #expect(bytes1 == bytes2)
    }

    @Test("compression is deterministic")
    func deterministic() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[5 * 11 + 5] = .king
        cells[10 * 11 + 10] = .defender
        let position = Position(cells: cells)
        let a = PositionCompressor.compress(position: position)
        let b = PositionCompressor.compress(position: position)
        #expect(a.count == b.count)
        for i in 0..<a.count {
            #expect(a[i] == b[i])
        }
    }
}
