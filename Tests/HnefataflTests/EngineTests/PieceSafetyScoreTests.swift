import Testing
@testable import Hnefatafl

@Suite("PieceSafetyScore Tests")
struct PieceSafetyScoreTests {

    @Test("empty square returns zero safety score")
    func emptySquareZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceSafetyScore.safetyScore(row: 5, col: 5, position: position) == 0)
    }

    @Test("isolated piece has low danger")
    func isolatedPieceLowDanger() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let score = PieceSafetyScore.safetyScore(row: 5, col: 5, position: position)
        #expect(score >= 0)
    }

    @Test("piece next to enemy has higher danger")
    func pieceNextToEnemyHigher() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let isolatedPos = Position(cells: cells)
        let isolatedScore = PieceSafetyScore.safetyScore(row: 5, col: 5, position: isolatedPos)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .attacker
        cells2[5 * 11 + 6] = .defender
        let adjPos = Position(cells: cells2)
        let adjScore = PieceSafetyScore.safetyScore(row: 5, col: 5, position: adjPos)

        #expect(adjScore > isolatedScore)
    }

    @Test("leastSafePiece returns a position for non-empty board")
    func leastSafePieceReturnsPosition() {
        let position = Position.copenhagenStart()
        let result = PieceSafetyScore.leastSafePiece(position: position, player: .attacker)
        #expect(result != nil)
    }

    @Test("leastSafePiece returns nil for empty board")
    func leastSafePieceEmptyBoard() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceSafetyScore.leastSafePiece(position: position, player: .attacker) == nil)
    }

    @Test("start position pieces have non-negative scores")
    func startPositionNonNegative() {
        let position = Position.copenhagenStart()
        let score = PieceSafetyScore.safetyScore(row: 0, col: 3, position: position)
        #expect(score >= 0)
    }
}
