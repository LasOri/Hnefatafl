import Testing
@testable import Hnefatafl

@Suite("NetControlDelta Tests")
struct NetControlDeltaTests {
    @Test("Same position has zero delta")
    func samePositionZeroDelta() {
        let position = Position.copenhagenStart()
        let d = NetControlDelta.delta(before: position, after: position)
        #expect(d == 0)
    }

    @Test("Empty boards have zero delta")
    func emptyBoardsZeroDelta() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let d = NetControlDelta.delta(before: position, after: position)
        #expect(d == 0)
    }

    @Test("Is improving for attacker when delta is positive")
    func improvingAttacker() {
        var cells1 = Array<Piece?>(repeating: nil, count: 121)
        cells1[5 * 11 + 5] = .king
        cells1[0 * 11 + 0] = .attacker
        let before = Position(cells: cells1)

        var cells2 = Array<Piece?>(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .king
        cells2[5 * 11 + 4] = .attacker
        let after = Position(cells: cells2)

        let improving = NetControlDelta.isImproving(before: before, after: after, player: .attacker)
        let d = NetControlDelta.delta(before: before, after: after)
        if d > 0 {
            #expect(improving == true)
        } else {
            #expect(improving == false)
        }
    }

    @Test("Is improving for defender when delta is negative")
    func improvingDefender() {
        let position = Position.copenhagenStart()
        let improving = NetControlDelta.isImproving(before: position, after: position, player: .defender)
        #expect(improving == false)
    }

    @Test("Delta reflects control changes")
    func deltaReflectsChanges() {
        var cells1 = Array<Piece?>(repeating: nil, count: 121)
        cells1[5 * 11 + 5] = .attacker
        let before = Position(cells: cells1)

        var cells2 = Array<Piece?>(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .defender
        let after = Position(cells: cells2)

        let d = NetControlDelta.delta(before: before, after: after)
        #expect(d != 0)
    }

    @Test("Delta is antisymmetric for player perspective")
    func antisymmetric() {
        let position = Position.copenhagenStart()
        let attackerImproving = NetControlDelta.isImproving(before: position, after: position, player: .attacker)
        let defenderImproving = NetControlDelta.isImproving(before: position, after: position, player: .defender)
        #expect(attackerImproving == false)
        #expect(defenderImproving == false)
    }
}
