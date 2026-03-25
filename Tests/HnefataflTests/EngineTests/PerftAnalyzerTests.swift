import Testing
@testable import Hnefatafl

@Suite("PerftAnalyzer Tests")
struct PerftAnalyzerTests {

    @Test("perft at depth 0 returns 1")
    func depthZero() {
        let pos = Position.copenhagenStart()
        #expect(PerftAnalyzer.perft(position: pos, player: .attacker, depth: 0) == 1)
    }

    @Test("perft at depth 1 equals legal move count")
    func depthOne() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let result = PerftAnalyzer.perft(position: pos, player: .attacker, depth: 1)
        #expect(result == moves.count)
    }

    @Test("perft divide sums to total perft")
    func divideConsistent() {
        let pos = Position.copenhagenStart()
        let divide = PerftAnalyzer.divide(position: pos, player: .attacker, depth: 1)
        let total = divide.reduce(0) { $0 + $1.count }
        let perftResult = PerftAnalyzer.perft(position: pos, player: .attacker, depth: 1)
        #expect(total == perftResult)
    }

    @Test("perft divide has one entry per legal move")
    func divideEntryCount() {
        let pos = Position.copenhagenStart()
        let divide = PerftAnalyzer.divide(position: pos, player: .attacker, depth: 1)
        let moves = pos.allLegalMoves(for: .attacker)
        #expect(divide.count == moves.count)
    }

    @Test("perft at depth 2 is positive")
    func depthTwo() {
        let pos = Position.copenhagenStart()
        let result = PerftAnalyzer.perft(position: pos, player: .attacker, depth: 2)
        #expect(result > 0)
    }

    @Test("perft with no legal moves returns 0 at depth 1")
    func noMoves() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let result = PerftAnalyzer.perft(position: pos, player: .attacker, depth: 1)
        #expect(result == 0)
    }

    @Test("perft depth 1 for single piece position")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let result = PerftAnalyzer.perft(position: pos, player: .defender, depth: 1)
        #expect(result > 0)
    }

    @Test("verify returns true for correct count")
    func verifyCorrect() {
        let pos = Position.copenhagenStart()
        let expected = pos.allLegalMoves(for: .attacker).count
        #expect(PerftAnalyzer.verify(position: pos, player: .attacker, depth: 1, expected: expected))
    }

    @Test("verify returns false for wrong count")
    func verifyWrong() {
        let pos = Position.copenhagenStart()
        #expect(!PerftAnalyzer.verify(position: pos, player: .attacker, depth: 1, expected: 0))
    }
}
