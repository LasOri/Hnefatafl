import Testing
@testable import Hnefatafl

@Suite("MoveSorter Tests")
struct MoveSorterTests {

    @Test("empty moves returns empty")
    func emptyMovesReturnsEmpty() {
        let position = Position.copenhagenStart()
        let sorted = MoveSorter.sort(moves: [], position: position, player: .attacker)
        #expect(sorted.isEmpty)
    }

    @Test("sort preserves move count")
    func sortPreservesCount() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let sorted = MoveSorter.sort(moves: moves, position: position, player: .attacker)
        #expect(sorted.count == moves.count)
    }

    @Test("capture moves ranked higher")
    func captureMovesRankedHigher() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .defender
        let position = Position(cells: cells)
        let captureMove = Move(fromRow: 5, fromCol: 3, toRow: 5, toCol: 3)
        let normalMove = Move(fromRow: 5, fromCol: 3, toRow: 3, toCol: 3)
        let captureScore = MoveSorter.heuristicScore(move: captureMove, position: position, player: .attacker)
        let normalScore = MoveSorter.heuristicScore(move: normalMove, position: position, player: .attacker)
        #expect(captureScore >= normalScore)
    }

    @Test("center moves preferred over edge")
    func centerPreferredOverEdge() {
        let position = Position.copenhagenStart()
        let centerMove = Move(fromRow: 0, fromCol: 5, toRow: 3, toCol: 5)
        let edgeMove = Move(fromRow: 0, fromCol: 5, toRow: 0, toCol: 2)
        let centerScore = MoveSorter.heuristicScore(move: centerMove, position: position, player: .attacker)
        let edgeScore = MoveSorter.heuristicScore(move: edgeMove, position: position, player: .attacker)
        #expect(centerScore >= edgeScore)
    }

    @Test("heuristic score is non-negative")
    func heuristicScoreNonNegative() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        for move in moves {
            let score = MoveSorter.heuristicScore(move: move, position: position, player: .attacker)
            #expect(score >= 0)
        }
    }

    @Test("sorted moves are all from original list")
    func sortedMovesAllLegal() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let sorted = MoveSorter.sort(moves: moves, position: position, player: .attacker)
        for move in sorted {
            #expect(moves.contains(move))
        }
    }
}
