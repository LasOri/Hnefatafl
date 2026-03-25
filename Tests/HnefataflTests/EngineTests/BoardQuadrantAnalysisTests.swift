import Testing
@testable import Hnefatafl

@Suite("BoardQuadrantAnalysis Tests")
struct BoardQuadrantAnalysisTests {
    @Test("QuadrantCounts initialization")
    func countsInit() {
        let counts = QuadrantCounts(topLeft: 1, topRight: 2, bottomLeft: 3, bottomRight: 4)
        #expect(counts.topLeft == 1)
        #expect(counts.topRight == 2)
        #expect(counts.bottomLeft == 3)
        #expect(counts.bottomRight == 4)
    }

    @Test("Analyze starting position for attackers")
    func analyzeStartAttackers() {
        let position = Position.copenhagenStart()
        let counts = BoardQuadrantAnalysis.analyze(position: position, player: .attacker)
        #expect(counts.topLeft >= 0)
        #expect(counts.topRight >= 0)
        #expect(counts.bottomLeft >= 0)
        #expect(counts.bottomRight >= 0)
    }

    @Test("Analyze starting position for defenders")
    func analyzeStartDefenders() {
        let position = Position.copenhagenStart()
        let counts = BoardQuadrantAnalysis.analyze(position: position, player: .defender)
        #expect(counts.topLeft >= 0)
        #expect(counts.topRight >= 0)
        #expect(counts.bottomLeft >= 0)
        #expect(counts.bottomRight >= 0)
    }

    @Test("Total counts match piece count")
    func totalMatches() {
        let position = Position.copenhagenStart()
        let counts = BoardQuadrantAnalysis.analyze(position: position, player: .attacker)
        let total = counts.topLeft + counts.topRight + counts.bottomLeft + counts.bottomRight
        #expect(total == position.attackerCount)
    }

    @Test("Defender total includes king")
    func defenderTotal() {
        let position = Position.copenhagenStart()
        let counts = BoardQuadrantAnalysis.analyze(position: position, player: .defender)
        let total = counts.topLeft + counts.topRight + counts.bottomLeft + counts.bottomRight
        #expect(total == position.defenderCount)
    }

    @Test("Quadrant counts are non-negative at start")
    func nonNegativeStart() {
        let position = Position.copenhagenStart()
        let attackerCounts = BoardQuadrantAnalysis.analyze(position: position, player: .attacker)
        #expect(attackerCounts.topLeft > 0)
        #expect(attackerCounts.topRight > 0)
        #expect(attackerCounts.bottomLeft > 0)
        #expect(attackerCounts.bottomRight > 0)
    }

    @Test("Empty position has zero counts")
    func emptyPosition() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let counts = BoardQuadrantAnalysis.analyze(position: emptyPosition, player: .attacker)
        #expect(counts.topLeft == 0)
        #expect(counts.topRight == 0)
        #expect(counts.bottomLeft == 0)
        #expect(counts.bottomRight == 0)
    }
}
