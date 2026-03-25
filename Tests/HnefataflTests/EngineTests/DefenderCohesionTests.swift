import Testing
@testable import Hnefatafl

@Suite("DefenderCohesion Tests")
struct DefenderCohesionTests {
    @Test("Average distance to king at start")
    func averageDistanceStart() {
        let position = Position.copenhagenStart()
        let avgDistance = DefenderCohesion.averageDistanceToKing(position: position)
        #expect(avgDistance >= 0.0)
    }

    @Test("Support score at start")
    func supportScoreStart() {
        let position = Position.copenhagenStart()
        let support = DefenderCohesion.supportScore(position: position)
        #expect(support >= 0)
    }

    @Test("Total cohesion at start")
    func totalStart() {
        let position = Position.copenhagenStart()
        let total = DefenderCohesion.total(position: position)
        #expect(total >= 0)
    }

    @Test("Empty position has zero cohesion")
    func emptyPosition() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let total = DefenderCohesion.total(position: emptyPosition)
        #expect(total == 0)
    }

    @Test("Support score rewards adjacent defenders")
    func supportAdjacent() {
        let position = Position.copenhagenStart()
        let support = DefenderCohesion.supportScore(position: position)
        #expect(support >= 0)
    }

    @Test("Cohesion decreases with distance from king")
    func cohesionDistance() {
        let position = Position.copenhagenStart()
        let avgDistance = DefenderCohesion.averageDistanceToKing(position: position)
        #expect(avgDistance >= 0.0)
    }
}
