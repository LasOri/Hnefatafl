import Testing
@testable import Hnefatafl

@Suite("Threat Map Tests")
struct ThreatMapTests {

    @Test("threat map has 121 entries")
    func entryCount() {
        let position = Position.copenhagenStart()
        let map = ThreatMap.compute(position: position, for: .attacker)
        #expect(map.count == 121)
    }

    @Test("empty board has no threats")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let map = ThreatMap.compute(position: position, for: .attacker)
        #expect(map.allSatisfy { $0 == 0 })
    }

    @Test("single attacker threatens reachable squares")
    func singleAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let map = ThreatMap.compute(position: position, for: .attacker)
        let threatened = map.filter { $0 > 0 }.count
        #expect(threatened > 0)
    }

    @Test("threat count increases with more pieces")
    func morePiecesMoreThreats() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[60] = .attacker
        let pos1 = Position(cells: cells1)
        let map1 = ThreatMap.compute(position: pos1, for: .attacker)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[60] = .attacker
        cells2[0] = .attacker
        let pos2 = Position(cells: cells2)
        let map2 = ThreatMap.compute(position: pos2, for: .attacker)

        #expect(ThreatMap.totalThreats(map: map2) >= ThreatMap.totalThreats(map: map1))
    }

    @Test("defender threat map is separate")
    func defenderMap() {
        let position = Position.copenhagenStart()
        let attackerMap = ThreatMap.compute(position: position, for: .attacker)
        let defenderMap = ThreatMap.compute(position: position, for: .defender)
        #expect(attackerMap != defenderMap)
    }

    @Test("totalThreats sums map")
    func totalThreats() {
        let position = Position.copenhagenStart()
        let map = ThreatMap.compute(position: position, for: .attacker)
        let total = ThreatMap.totalThreats(map: map)
        #expect(total > 0)
    }

    @Test("threat at specific square")
    func threatAtSquare() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let map = ThreatMap.compute(position: position, for: .attacker)
        #expect(map[5 * 11 + 6] > 0)
    }

    @Test("occupied square not threatened by own piece")
    func ownPieceNotThreatened() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .attacker
        let position = Position(cells: cells)
        let map = ThreatMap.compute(position: position, for: .attacker)
        #expect(map[60] == 0)
    }
}
