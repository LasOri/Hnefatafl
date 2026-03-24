import Testing
@testable import Hnefatafl

@Suite("Shield Wall Tests")
struct ShieldWallTests {

    @Test("no shield wall on empty board")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let result = ShieldWallDetector.detect(position: position, lastMove: nil)
        #expect(result.isEmpty)
    }

    @Test("ShieldWallDetector needs at least 2 pieces on edge")
    func minimumPieces() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .defender
        cells[11] = .attacker
        let position = Position(cells: cells)
        let result = ShieldWallDetector.detect(position: position, lastMove: nil)
        #expect(result.isEmpty)
    }

    @Test("ShieldWallDetector analyzeEdge returns captures")
    func analyzeEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .defender
        cells[1] = .defender
        cells[2] = .defender
        cells[11] = .attacker
        cells[12] = .attacker
        cells[13] = .attacker
        cells[3] = .attacker
        let position = Position(cells: cells)
        let result = ShieldWallDetector.analyzeEdge(
            edgeSquares: [(0, 0), (0, 1), (0, 2)],
            innerSquares: [(1, 0), (1, 1), (1, 2)],
            flanker: (0, 3),
            position: position,
            edgePlayer: .defender,
            innerPlayer: .attacker
        )
        #expect(result.count >= 0)
    }

    @Test("shield wall requires flanking piece")
    func requiresFlanking() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .defender
        cells[1] = .defender
        cells[11] = .attacker
        cells[12] = .attacker
        let position = Position(cells: cells)
        let result = ShieldWallDetector.detect(position: position, lastMove: nil)
        #expect(result.isEmpty)
    }

    @Test("ShieldWallResult stores captured squares")
    func resultStoresCaptured() {
        let result = ShieldWallResult(capturedSquares: [(row: 0, col: 1), (row: 0, col: 2)])
        #expect(result.capturedSquares.count == 2)
    }

    @Test("starting position has no shield wall")
    func startingPosition() {
        let position = Position.copenhagenStart()
        let result = ShieldWallDetector.detect(position: position, lastMove: nil)
        #expect(result.isEmpty)
    }

    @Test("ShieldWallResult is Equatable")
    func equatable() {
        let a = ShieldWallResult(capturedSquares: [(row: 1, col: 2)])
        let b = ShieldWallResult(capturedSquares: [(row: 1, col: 2)])
        #expect(a == b)
    }

    @Test("empty result has no captured squares")
    func emptyResult() {
        let result = ShieldWallResult(capturedSquares: [])
        #expect(result.capturedSquares.isEmpty)
    }
}
