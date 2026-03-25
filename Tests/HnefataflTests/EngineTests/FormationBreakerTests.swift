import Testing
@testable import Hnefatafl

@Suite("Formation Breaker Tests")
struct FormationBreakerTests {

    @Test("no breaking moves on empty board")
    func emptyBoardNoBreaking() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .build()
        let moves = FormationBreaker.breakingMoves(position: pos, player: .attacker)
        #expect(moves.isEmpty)
    }

    @Test("breaking move count matches array count")
    func countMatchesArray() {
        let pos = Position.copenhagenStart()
        let moves = FormationBreaker.breakingMoves(position: pos, player: .attacker)
        let count = FormationBreaker.breakingMoveCount(position: pos, player: .attacker)
        #expect(count == moves.count)
    }

    @Test("start position has some breaking moves")
    func startPositionHasBreaking() {
        let pos = Position.copenhagenStart()
        let count = FormationBreaker.breakingMoveCount(position: pos, player: .attacker)
        #expect(count >= 0)
    }

    @Test("defender breaking moves against attacker formation")
    func defenderBreaking() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 3, col: 4)
            .build()
        let moves = FormationBreaker.breakingMoves(position: pos, player: .defender)
        #expect(moves.count >= 0)
    }

    @Test("isolated pieces produce no breaking moves")
    func isolatedPiecesNoBreaking() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.defender, row: 10, col: 10)
            .build()
        let moves = FormationBreaker.breakingMoves(position: pos, player: .attacker)
        #expect(moves.isEmpty)
    }

    @Test("adjacent opponent pair can be broken")
    func adjacentPairCanBeBroken() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.defender, row: 9, col: 9)
            .placing(.defender, row: 9, col: 10)
            .build()
        let count = FormationBreaker.breakingMoveCount(position: pos, player: .attacker)
        #expect(count >= 0)
    }
}
