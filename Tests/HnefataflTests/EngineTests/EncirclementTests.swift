import Testing
@testable import Hnefatafl

@Suite("Encirclement Tests")
struct EncirclementTests {

    @Test("starting position is not encircled")
    func startingNotEncircled() {
        let position = Position.copenhagenStart()
        #expect(!EncirclementDetector.isKingEncircled(position: position))
    }

    @Test("king alone is not encircled")
    func kingAloneNotEncircled() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        let position = Position(cells: cells)
        #expect(!EncirclementDetector.isKingEncircled(position: position))
    }

    @Test("king surrounded on 4 sides by attackers")
    func surroundedByAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        #expect(EncirclementDetector.isKingEncircled(position: position))
    }

    @Test("king with one escape not encircled")
    func oneEscape() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(!EncirclementDetector.isKingEncircled(position: position))
    }

    @Test("encirclement count returns adjacent attackers")
    func adjacentAttackerCount() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let count = EncirclementDetector.adjacentAttackers(position: position)
        #expect(count == 2)
    }

    @Test("empty board has zero adjacent attackers")
    func emptyAdjacentAttackers() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let count = EncirclementDetector.adjacentAttackers(position: position)
        #expect(count == 0)
    }

    @Test("king at edge with wall counts as encircled side")
    func kingAtEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 4] = .attacker
        cells[0 * 11 + 6] = .attacker
        cells[1 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(EncirclementDetector.isKingEncircled(position: position))
    }

    @Test("king at corner with two attackers is encircled")
    func kingAtCornerEncircled() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .attacker
        cells[11] = .attacker
        let position = Position(cells: cells)
        #expect(EncirclementDetector.isKingEncircled(position: position))
    }
}
