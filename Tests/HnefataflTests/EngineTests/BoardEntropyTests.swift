import Testing
@testable import Hnefatafl

@Suite("BoardEntropy Tests")
struct BoardEntropyTests {

    @Test("starting position has entropy")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let entropy = BoardEntropy.compute(position: pos)
        #expect(entropy > 0)
    }

    @Test("empty board has zero entropy")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let entropy = BoardEntropy.compute(position: pos)
        #expect(entropy == 0)
    }

    @Test("entropy is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let entropy = BoardEntropy.compute(position: pos)
        #expect(entropy >= 0)
    }

    @Test("single piece has low entropy")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let entropy = BoardEntropy.compute(position: pos)
        #expect(entropy < 10)
    }

    @Test("more pieces means higher entropy")
    func morePieces() {
        let pos1 = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let pos2 = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 0)
            .place(.attacker, row: 10, col: 10)
            .place(.defender, row: 3, col: 3)
            .build()
        let e1 = BoardEntropy.compute(position: pos1)
        let e2 = BoardEntropy.compute(position: pos2)
        #expect(e2 > e1)
    }

    @Test("entropy is bounded")
    func bounded() {
        let pos = Position.copenhagenStart()
        let entropy = BoardEntropy.compute(position: pos)
        #expect(entropy <= 1000)
    }
}
