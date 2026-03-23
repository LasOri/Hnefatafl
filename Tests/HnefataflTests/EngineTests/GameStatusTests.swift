import Testing
@testable import Hnefatafl

@Suite("Game Status Tests")
struct GameStatusTests {

    @Test("allLegalMoves returns moves for all attacker pieces")
    func allLegalMoves_attacker_returnsMovesForAllAttackers() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 3)
            .placing(.attacker, row: 5, col: 7)
            .build()

        let moves = position.allLegalMoves(for: .attacker)

        let fromCols = Set(moves.map { $0.fromCol })
        #expect(fromCols.contains(3))
        #expect(fromCols.contains(7))
    }

    @Test("allLegalMoves returns moves for defender pieces including king")
    func allLegalMoves_defender_includesKingMoves() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()

        let moves = position.allLegalMoves(for: .defender)

        let fromCols = Set(moves.map { $0.fromCol })
        #expect(fromCols.contains(3))
        #expect(fromCols.contains(5))
    }

    @Test("stalemate: attacker with no moves loses")
    func gameStatus_attackerNoMoves_defenderWins() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 1)
            .placing(.defender, row: 0, col: 2)
            .placing(.defender, row: 1, col: 1)
            .placing(.king, row: 5, col: 5)
            .build()

        let status = Position.gameStatus(position, currentPlayer: .attacker)

        #expect(status == .defenderWins)
    }
}
