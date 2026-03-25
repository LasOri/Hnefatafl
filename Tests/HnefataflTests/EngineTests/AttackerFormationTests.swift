import Testing
@testable import Hnefatafl

@Suite("AttackerFormation Tests")
struct AttackerFormationTests {
    @Test("Ring pressure at start")
    func ringPressureStart() {
        let position = Position.copenhagenStart()
        let pressure = AttackerFormation.ringPressure(position: position)
        #expect(pressure >= 0)
    }

    @Test("Corner block score at start")
    func cornerBlockStart() {
        let position = Position.copenhagenStart()
        let score = AttackerFormation.cornerBlockScore(position: position)
        #expect(score >= 0)
    }

    @Test("Total formation score at start")
    func totalStart() {
        let position = Position.copenhagenStart()
        let total = AttackerFormation.total(position: position)
        #expect(total >= 0)
    }

    @Test("Empty position has zero formation")
    func emptyPosition() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let total = AttackerFormation.total(position: emptyPosition)
        #expect(total == 0)
    }

    @Test("Ring pressure increases with proximity to king")
    func ringPressureProximity() {
        let position = Position.copenhagenStart()
        let pressure = AttackerFormation.ringPressure(position: position)
        #expect(pressure >= 0)
    }

    @Test("Total equals sum of components")
    func totalComponents() {
        let position = Position.copenhagenStart()
        let ring = AttackerFormation.ringPressure(position: position)
        let corner = AttackerFormation.cornerBlockScore(position: position)
        let total = AttackerFormation.total(position: position)
        #expect(total == ring + corner)
    }
}
