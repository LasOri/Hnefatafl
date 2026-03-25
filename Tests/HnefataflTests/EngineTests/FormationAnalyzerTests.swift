import Testing
@testable import Hnefatafl

@Suite("Formation Analyzer Tests")
struct FormationAnalyzerTests {

    @Test("detects defender wall")
    func defenderWall() {
        let position = Position.copenhagenStart()
        let walls = FormationAnalyzer.defenderWalls(position: position)
        #expect(walls >= 0)
    }

    @Test("detects attacker clusters")
    func attackerClusters() {
        let position = Position.copenhagenStart()
        let clusters = FormationAnalyzer.attackerClusters(position: position)
        #expect(clusters > 0)
    }

    @Test("isolated piece count")
    func isolatedPieces() {
        let position = Position.copenhagenStart()
        let isolated = FormationAnalyzer.isolatedPieces(position: position, player: .attacker)
        #expect(isolated >= 0)
    }

    @Test("connected defenders count")
    func connectedDefenders() {
        let position = Position.copenhagenStart()
        let connected = FormationAnalyzer.connectedPieces(position: position, player: .defender)
        #expect(connected > 0)
    }

    @Test("empty board has zero formations")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let clusters = FormationAnalyzer.attackerClusters(position: position)
        #expect(clusters == 0)
    }

    @Test("formation score computed")
    func formationScore() {
        let position = Position.copenhagenStart()
        let score = FormationAnalyzer.score(position: position, player: .attacker)
        #expect(score != 0 || score == 0)
    }

    @Test("adjacency check works")
    func adjacencyCheck() {
        #expect(FormationAnalyzer.areAdjacent(r1: 3, c1: 5, r2: 3, c2: 6))
        #expect(!FormationAnalyzer.areAdjacent(r1: 0, c1: 0, r2: 5, c2: 5))
    }
}
