import Testing
@testable import Hnefatafl

@Suite("AttackerReserve Tests")
struct AttackerReserveTests {

    @Test("start position has reserves")
    func startPositionHasReserves() {
        let pos = Position.copenhagenStart()
        let count = AttackerReserve.reserveCount(position: pos)
        #expect(count > 0)
    }

    @Test("empty board has zero reserves")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let count = AttackerReserve.reserveCount(position: pos)
        #expect(count == 0)
    }

    @Test("attacker at center is not a reserve")
    func centerAttackerNotReserve() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let count = AttackerReserve.reserveCount(position: pos)
        #expect(count == 0)
    }

    @Test("attacker at edge counts as reserve")
    func edgeAttackerIsReserve() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let count = AttackerReserve.reserveCount(position: pos)
        #expect(count == 1)
    }

    @Test("reserve strength increases with distance")
    func strengthIncreasesWithDistance() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[0] = .attacker
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[3 * 11 + 3] = .attacker
        let pos2 = Position(cells: cells2)

        let s1 = AttackerReserve.reserveStrength(position: pos1)
        let s2 = AttackerReserve.reserveStrength(position: pos2)
        #expect(s1 >= s2)
    }

    @Test("reserve strength is zero for empty board")
    func strengthZeroEmpty() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let s = AttackerReserve.reserveStrength(position: pos)
        #expect(s == 0)
    }
}
