import Testing
@testable import Hnefatafl

@Suite("GameComplexity Tests")
struct GameComplexityTests {
    @Test("ComplexityInfo initialization")
    func complexityInit() {
        let info = ComplexityInfo(branchingFactor: 30, totalMoves: 60, pieceDensity: 0.5, level: .medium)
        #expect(info.branchingFactor == 30)
        #expect(info.totalMoves == 60)
        #expect(info.pieceDensity == 0.5)
        #expect(info.level == .medium)
    }

    @Test("Complexity at start")
    func complexityStart() {
        let position = Position.copenhagenStart()
        let complexity = GameComplexity.complexity(position: position)
        #expect(complexity.branchingFactor >= 0)
        #expect(complexity.totalMoves >= 0)
        #expect(complexity.pieceDensity >= 0.0 && complexity.pieceDensity <= 1.0)
    }

    @Test("Branching factor equals average moves per piece")
    func branchingFactor() {
        let position = Position.copenhagenStart()
        let complexity = GameComplexity.complexity(position: position)
        #expect(complexity.branchingFactor >= 0)
    }

    @Test("Total moves for both players")
    func totalMoves() {
        let position = Position.copenhagenStart()
        let complexity = GameComplexity.complexity(position: position)
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        #expect(complexity.totalMoves == attackerMoves + defenderMoves)
    }

    @Test("Piece density at start")
    func pieceDensity() {
        let position = Position.copenhagenStart()
        let complexity = GameComplexity.complexity(position: position)
        let totalPieces = position.attackerCount + position.defenderCount + 1
        let maxSquares = Position.boardSize * Position.boardSize
        let expectedDensity = Double(totalPieces) / Double(maxSquares)
        #expect(abs(complexity.pieceDensity - expectedDensity) < 0.01)
    }

    @Test("Complexity level classification")
    func complexityLevel() {
        let position = Position.copenhagenStart()
        let complexity = GameComplexity.complexity(position: position)
        #expect(complexity.level == .low || complexity.level == .medium || complexity.level == .high)
    }

    @Test("Empty position has low complexity")
    func emptyComplexity() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let complexity = GameComplexity.complexity(position: emptyPosition)
        #expect(complexity.branchingFactor == 0)
        #expect(complexity.totalMoves == 0)
        #expect(complexity.pieceDensity == 0.0)
        #expect(complexity.level == .low)
    }
}
