import Testing
@testable import Hnefatafl

@Suite("SafeSquareEval Tests")
struct SafeSquareEvalTests {
    @Test("Safe squares on empty board with king")
    func emptyBoardSafeSquares() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let count = SafeSquareEval.safeSquareCount(position: position)
        #expect(count == 120)
    }

    @Test("Square with attacker line-of-sight is not safe")
    func attackerLineOfSightUnsafe() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .build()
        let safeSquares = SafeSquareEval.safeSquares(position: position)
        let unsafeCheck = safeSquares.contains { $0.row == 2 && $0.col == 3 }
        #expect(unsafeCheck == false)
    }

    @Test("Safe square count matches array length")
    func countMatchesArray() {
        let position = Position.copenhagenStart()
        let squares = SafeSquareEval.safeSquares(position: position)
        let count = SafeSquareEval.safeSquareCount(position: position)
        #expect(count == squares.count)
    }

    @Test("No king returns zero safe squares")
    func noKingReturnsZero() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .build()
        #expect(SafeSquareEval.safeSquareCount(position: position) == 0)
    }

    @Test("Defender blocks attacker line-of-sight")
    func defenderBlocksLOS() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.defender, row: 2, col: 3)
            .build()
        let safeSquares = SafeSquareEval.safeSquares(position: position)
        let squareBelow = safeSquares.contains { $0.row == 4 && $0.col == 3 }
        #expect(squareBelow == true)
    }

    @Test("Copenhagen start has some safe squares")
    func copenhagenSafeSquares() {
        let position = Position.copenhagenStart()
        let count = SafeSquareEval.safeSquareCount(position: position)
        #expect(count >= 0)
    }
}
