import Testing
@testable import Hnefatafl

@Suite("TacticalMotive Tests")
struct TacticalMotiveTests {

    @Test("empty board has no tactical motives")
    func emptyBoardNoMotives() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let motives = TacticalMotive.classify(position: position, player: .attacker)
        #expect(motives == [.none])
    }

    @Test("hasTacticalMotive is false for empty board")
    func emptyBoardHasTacticalMotiveFalse() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(TacticalMotive.hasTacticalMotive(position: position, player: .attacker) == false)
    }

    @Test("classify returns non-empty array")
    func classifyReturnsNonEmpty() {
        let position = Position.copenhagenStart()
        let motives = TacticalMotive.classify(position: position, player: .attacker)
        #expect(!motives.isEmpty)
    }

    @Test("TacticalMotiveType has five cases")
    func motiveTypeHasFiveCases() {
        let cases = TacticalMotiveType.allCases
        #expect(cases.count == 5)
        #expect(cases.contains(.fork))
        #expect(cases.contains(.pin))
        #expect(cases.contains(.skewer))
        #expect(cases.contains(.discoveredAttack))
        #expect(cases.contains(.none))
    }

    @Test("defender motives on start position")
    func defenderMotivesOnStart() {
        let position = Position.copenhagenStart()
        let motives = TacticalMotive.classify(position: position, player: .defender)
        #expect(!motives.isEmpty)
    }

    @Test("hasTacticalMotive consistent with classify")
    func hasTacticalConsistentWithClassify() {
        let position = Position.copenhagenStart()
        let motives = TacticalMotive.classify(position: position, player: .attacker)
        let hasMotive = TacticalMotive.hasTacticalMotive(position: position, player: .attacker)
        #expect(hasMotive == (motives != [.none]))
    }

    @Test("classify does not contain none alongside real motives")
    func noneNotMixedWithReal() {
        let position = Position.copenhagenStart()
        let motives = TacticalMotive.classify(position: position, player: .attacker)
        if motives.contains(.none) {
            #expect(motives.count == 1)
        }
    }
}
