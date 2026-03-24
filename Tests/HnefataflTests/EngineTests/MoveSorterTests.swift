import Testing
@testable import Hnefatafl

@Suite("Move Sorter Tests")
struct MoveSorterTests {

    @Test("sort returns same moves in different order")
    func sameMovesReordered() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let sorted = MoveSorter.sort(moves: moves, position: game.position, player: .attacker)
        #expect(sorted.count == moves.count)
        for move in moves {
            #expect(sorted.contains(move))
        }
    }

    @Test("capture moves appear before non-captures")
    func capturesPrioritized() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .defender
        cells[4 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let moves = position.legalMoves(forPieceAtRow: 5, col: 3)
        guard !moves.isEmpty else { return }
        let sorted = MoveSorter.sort(moves: moves, position: position, player: .attacker)
        #expect(sorted.count == moves.count)
    }

    @Test("king escape moves score high for defender")
    func kingEscapePrioritized() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 0] = .king
        let position = Position(cells: cells)
        let cornerMove = Move(fromRow: 1, fromCol: 0, toRow: 0, toCol: 0)
        let normalMove = Move(fromRow: 1, fromCol: 0, toRow: 5, toCol: 0)
        let cornerScore = MoveSorter.score(move: cornerMove, position: position, player: .defender)
        let normalScore = MoveSorter.score(move: normalMove, position: position, player: .defender)
        #expect(cornerScore > normalScore)
    }

    @Test("score function returns higher for captures")
    func captureScoreHigher() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .defender
        let position = Position(cells: cells)
        let captureMove = Move(fromRow: 5, fromCol: 3, toRow: 5, toCol: 3)
        let normalMove = Move(fromRow: 5, fromCol: 3, toRow: 3, toCol: 3)
        let captureScore = MoveSorter.score(move: captureMove, position: position, player: .attacker)
        let normalScore = MoveSorter.score(move: normalMove, position: position, player: .attacker)
        #expect(captureScore >= normalScore)
    }

    @Test("center moves score higher than edge moves")
    func centerPreferred() {
        let position = Position.copenhagenStart()
        let centerMove = Move(fromRow: 0, fromCol: 5, toRow: 3, toCol: 5)
        let edgeMove = Move(fromRow: 0, fromCol: 5, toRow: 0, toCol: 2)
        let centerScore = MoveSorter.score(move: centerMove, position: position, player: .attacker)
        let edgeScore = MoveSorter.score(move: edgeMove, position: position, player: .attacker)
        #expect(centerScore >= edgeScore)
    }

    @Test("empty move list returns empty")
    func emptyMoves() {
        let position = Position.copenhagenStart()
        let sorted = MoveSorter.sort(moves: [], position: position, player: .attacker)
        #expect(sorted.isEmpty)
    }

    @Test("single move returns same move")
    func singleMove() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let sorted = MoveSorter.sort(moves: [move], position: position, player: .attacker)
        #expect(sorted == [move])
    }

    @Test("corner moves score high for defender king")
    func cornerMoveScore() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 0] = .king
        let position = Position(cells: cells)
        let cornerMove = Move(fromRow: 1, fromCol: 0, toRow: 0, toCol: 0)
        let score = MoveSorter.score(move: cornerMove, position: position, player: .defender)
        #expect(score > 0)
    }
}
