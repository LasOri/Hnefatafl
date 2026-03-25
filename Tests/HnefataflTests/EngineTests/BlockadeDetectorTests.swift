import Testing
@testable import Hnefatafl

@Suite("Blockade Detector Tests")
struct BlockadeDetectorTests {

    @Test("king with open adjacent square is not blockaded")
    func kingWithOpenSquareNotBlockaded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        #expect(!BlockadeDetector.isKingBlockaded(position: pos))
    }

    @Test("blockade strength at start is nonzero")
    func blockadeStrengthAtStart() {
        let pos = Position.copenhagenStart()
        let strength = BlockadeDetector.blockadeStrength(position: pos)
        #expect(strength > 0)
    }

    @Test("empty board not blockaded")
    func emptyBoardNotBlockaded() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(!BlockadeDetector.isKingBlockaded(position: pos))
    }

    @Test("strength zero for no king")
    func strengthZeroForNoKing() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let strength = BlockadeDetector.blockadeStrength(position: pos)
        #expect(strength == 0)
    }

    @Test("completely surrounded king is blockaded")
    func surroundedKingBlockaded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        let kingRow = 5
        let kingCol = 5
        cells[kingRow * 11 + kingCol] = .king
        cells[kingRow * 11 + (kingCol + 1)] = .attacker
        cells[kingRow * 11 + (kingCol - 1)] = .attacker
        cells[(kingRow + 1) * 11 + kingCol] = .attacker
        cells[(kingRow - 1) * 11 + kingCol] = .attacker
        let pos = Position(cells: cells)
        #expect(BlockadeDetector.isKingBlockaded(position: pos))
    }
}
