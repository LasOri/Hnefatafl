import Testing
@testable import Hnefatafl

@Suite("Piece Activity Score Extended Tests")
struct PieceActivityScoreExtendedTests {

    @Test("score returns sum of legal moves for player")
    func scoreReturnsMoveSums() {
        let position = Position.copenhagenStart()
        let score = PieceActivityScore.score(position: position, player: .attacker)
        #expect(score > 0)
    }

    @Test("score for empty board is zero")
    func scoreEmptyBoard() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceActivityScore.score(position: position, player: .attacker) == 0)
        #expect(PieceActivityScore.score(position: position, player: .defender) == 0)
    }

    @Test("score matches compute for same player")
    func scoreMatchesCompute() {
        let position = Position.copenhagenStart()
        let score = PieceActivityScore.score(position: position, player: .attacker)
        let compute = PieceActivityScore.compute(position: position, player: .attacker)
        #expect(score == compute)
    }

    @Test("mostActivePiece returns nil for empty board")
    func mostActivePieceEmptyBoard() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceActivityScore.mostActivePiece(position: position, player: .attacker) == nil)
    }

    @Test("mostActivePiece returns a piece in starting position")
    func mostActivePieceStarting() {
        let position = Position.copenhagenStart()
        let result = PieceActivityScore.mostActivePiece(position: position, player: .attacker)
        #expect(result != nil)
        if let result {
            let piece = position.pieceAt(row: result.row, col: result.col)
            #expect(piece == .attacker)
        }
    }

    @Test("mostActivePiece for defender returns defender or king")
    func mostActivePieceDefender() {
        let position = Position.copenhagenStart()
        let result = PieceActivityScore.mostActivePiece(position: position, player: .defender)
        #expect(result != nil)
        if let result {
            let piece = position.pieceAt(row: result.row, col: result.col)
            #expect(piece == .defender || piece == .king)
        }
    }

    @Test("single piece has score equal to its move count")
    func singlePieceScore() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .build()
        let moveCount = position.legalMoves(forPieceAtRow: 3, col: 3).count
        let score = PieceActivityScore.score(position: position, player: .attacker)
        #expect(score == moveCount)
    }
}
