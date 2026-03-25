import Testing
@testable import Hnefatafl

@Suite("Threat Level Tests")
struct ThreatLevelTests {

    @Test("no attackers near king means no threat")
    func noThreat() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let severity = ThreatLevel.assess(position: position)
        #expect(severity == .none)
    }

    @Test("one adjacent attacker is low threat")
    func lowThreat() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let severity = ThreatLevel.assess(position: position)
        #expect(severity == .low)
    }

    @Test("two adjacent attackers is medium threat")
    func mediumThreat() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 5, col: 4)
            .build()
        let severity = ThreatLevel.assess(position: position)
        #expect(severity == .medium)
    }

    @Test("three adjacent attackers is high threat")
    func highThreat() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 4, col: 5)
            .build()
        let severity = ThreatLevel.assess(position: position)
        #expect(severity == .high)
    }

    @Test("severity is comparable")
    func severityComparable() {
        #expect(ThreatSeverity.none < ThreatSeverity.low)
        #expect(ThreatSeverity.low < ThreatSeverity.critical)
    }
}
