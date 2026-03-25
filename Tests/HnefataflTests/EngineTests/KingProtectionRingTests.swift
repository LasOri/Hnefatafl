import Testing
@testable import Hnefatafl

@Suite("King Protection Ring Tests")
struct KingProtectionRingTests {

    @Test("ring strength counts defenders around king")
    func ringStrengthBasic() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[6 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .defender
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringStrength(position: position) == 3)
    }

    @Test("ring strength ignores attackers")
    func ringStrengthIgnoresAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .defender
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringStrength(position: position) == 1)
    }

    @Test("ring strength includes diagonal defenders")
    func ringStrengthDiagonals() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 4] = .defender
        cells[6 * 11 + 6] = .defender
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringStrength(position: position) == 2)
    }

    @Test("ring gaps counts empty squares around king")
    func ringGapsBasic() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringGaps(position: position) == 8)
    }

    @Test("ring gaps reduced by surrounding pieces")
    func ringGapsWithPieces() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringGaps(position: position) == 6)
    }

    @Test("returns zero when no king on board")
    func noKing() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringStrength(position: position) == 0)
        #expect(KingProtectionRing.ringGaps(position: position) == 0)
    }

    @Test("king in corner has fewer ring squares")
    func kingInCornerArea() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .king
        cells[0 * 11 + 1] = .defender
        cells[1 * 11 + 0] = .defender
        cells[1 * 11 + 1] = .defender
        let position = Position(cells: cells)
        #expect(KingProtectionRing.ringStrength(position: position) == 3)
        #expect(KingProtectionRing.ringGaps(position: position) == 0)
    }
}
