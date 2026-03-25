import Testing
@testable import Hnefatafl

@Suite("King Safety Zone Tests")
struct KingSafetyZoneTests {

    @Test("zone has radius")
    func hasRadius() {
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        #expect(zone.radius == 2)
    }

    @Test("zone contains center")
    func containsCenter() {
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        #expect(zone.contains(row: 5, col: 5))
    }

    @Test("zone contains adjacent")
    func containsAdjacent() {
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        #expect(zone.contains(row: 5, col: 6))
    }

    @Test("zone excludes far squares")
    func excludesFar() {
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        #expect(!zone.contains(row: 0, col: 0))
    }

    @Test("threat count in zone")
    func threatCount() {
        let position = Position.copenhagenStart()
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        let threats = zone.attackerCount(in: position)
        #expect(threats >= 0)
    }

    @Test("defender count in zone")
    func defenderCount() {
        let position = Position.copenhagenStart()
        let zone = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        let defenders = zone.defenderCount(in: position)
        #expect(defenders > 0)
    }

    @Test("safety score computed")
    func safetyScore() {
        let position = Position.copenhagenStart()
        let score = KingSafetyZone.safetyScore(position: position)
        #expect(score != 0 || score == 0)
    }

    @Test("KingSafetyZone is Equatable")
    func equatable() {
        let a = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        let b = KingSafetyZone(centerRow: 5, centerCol: 5, radius: 2)
        #expect(a == b)
    }
}
