import Testing
@testable import Hnefatafl

@Suite("AttackPattern Tests")
struct AttackPatternTests {

    @Test("no attackers returns none")
    func noAttackers() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let pattern = AttackPattern.classify(position: pos)
        #expect(pattern == .none)
    }

    @Test("attackers surrounding king is siege")
    func siege() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 4, col: 5)
            .place(.attacker, row: 6, col: 5)
            .place(.attacker, row: 5, col: 4)
            .place(.attacker, row: 5, col: 6)
            .place(.attacker, row: 3, col: 5)
            .place(.attacker, row: 7, col: 5)
            .build()
        let pattern = AttackPattern.classify(position: pos)
        #expect(pattern == .siege)
    }

    @Test("attackers on one side is flanking")
    func flanking() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 3)
            .place(.attacker, row: 0, col: 4)
            .place(.attacker, row: 0, col: 5)
            .place(.attacker, row: 0, col: 6)
            .place(.attacker, row: 0, col: 7)
            .build()
        let pattern = AttackPattern.classify(position: pos)
        #expect(pattern == .flanking)
    }

    @Test("PatternType is Equatable")
    func equatable() {
        #expect(AttackPatternType.siege == AttackPatternType.siege)
        #expect(AttackPatternType.siege != AttackPatternType.flanking)
    }

    @Test("starting position has encirclement")
    func startEncirclement() {
        let pos = Position.copenhagenStart()
        let pattern = AttackPattern.classify(position: pos)
        #expect(pattern == .encirclement)
    }

    @Test("all pattern types exist")
    func allTypes() {
        let types: [AttackPatternType] = [.encirclement, .siege, .flanking, .scattered, .none]
        #expect(types.count == 5)
    }

    @Test("scattered attackers detected")
    func scattered() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 0)
            .place(.attacker, row: 10, col: 10)
            .build()
        let pattern = AttackPattern.classify(position: pos)
        #expect(pattern == .scattered)
    }
}
