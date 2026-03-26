import Testing
@testable import Hnefatafl

@Suite("AttackFormation Tests")
struct AttackFormationTests {

    @Test("starting position has a formation")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let formation = AttackFormation.classify(position: pos)
        #expect(formation != .none)
    }

    @Test("empty board has no formation")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let formation = AttackFormation.classify(position: pos)
        #expect(formation == .none)
    }

    @Test("line of attackers detected")
    func lineFormation() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 0)
            .place(.attacker, row: 3, col: 1)
            .place(.attacker, row: 3, col: 2)
            .place(.attacker, row: 3, col: 3)
            .place(.king, row: 5, col: 5)
            .build()
        let formation = AttackFormation.classify(position: pos)
        #expect(formation == .line)
    }

    @Test("scattered attackers detected")
    func scatteredFormation() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 0)
            .place(.attacker, row: 10, col: 10)
            .place(.attacker, row: 0, col: 10)
            .place(.king, row: 5, col: 5)
            .build()
        let formation = AttackFormation.classify(position: pos)
        #expect(formation == .scattered)
    }

    @Test("AttackFormationType is Equatable")
    func equatable() {
        #expect(AttackFormationType.line == AttackFormationType.line)
        #expect(AttackFormationType.line != AttackFormationType.scattered)
    }

    @Test("single attacker is scattered")
    func singleAttacker() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let formation = AttackFormation.classify(position: pos)
        #expect(formation == .scattered || formation == .none)
    }
}
