import Testing
@testable import Hnefatafl

@Suite("BoardSector Tests")
struct BoardSectorTests {

    @Test("corners identified correctly")
    func cornersIdentified() {
        #expect(BoardSector.sector(row: 0, col: 0) == .corner)
        #expect(BoardSector.sector(row: 0, col: 10) == .corner)
        #expect(BoardSector.sector(row: 10, col: 0) == .corner)
        #expect(BoardSector.sector(row: 10, col: 10) == .corner)
    }

    @Test("edges identified correctly")
    func edgesIdentified() {
        #expect(BoardSector.sector(row: 0, col: 5) == .edge)
        #expect(BoardSector.sector(row: 10, col: 5) == .edge)
        #expect(BoardSector.sector(row: 5, col: 0) == .edge)
        #expect(BoardSector.sector(row: 5, col: 10) == .edge)
    }

    @Test("center identified correctly")
    func centerIdentified() {
        #expect(BoardSector.sector(row: 5, col: 5) == .center)
        #expect(BoardSector.sector(row: 3, col: 3) == .center)
        #expect(BoardSector.sector(row: 7, col: 7) == .center)
    }

    @Test("sector type cases")
    func sectorTypeCases() {
        let cases = BoardSectorType.allCases
        #expect(cases.count == 3)
        #expect(cases.contains(.center))
        #expect(cases.contains(.edge))
        #expect(cases.contains(.corner))
    }

    @Test("piece count by sector on start position")
    func startPositionCounts() {
        let position = Position.copenhagenStart()
        let attackerCounts = BoardSector.pieceCountBySector(position: position, player: .attacker)
        let defenderCounts = BoardSector.pieceCountBySector(position: position, player: .defender)
        let totalAttackers = (attackerCounts[.center] ?? 0) + (attackerCounts[.edge] ?? 0) + (attackerCounts[.corner] ?? 0)
        let totalDefenders = (defenderCounts[.center] ?? 0) + (defenderCounts[.edge] ?? 0) + (defenderCounts[.corner] ?? 0)
        #expect(totalAttackers == position.attackerCount)
        #expect(totalDefenders == position.defenderCount)
    }

    @Test("empty board has zero in all sectors")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let counts = BoardSector.pieceCountBySector(position: position, player: .attacker)
        #expect(counts[.center] == 0)
        #expect(counts[.edge] == 0)
        #expect(counts[.corner] == 0)
    }

    @Test("sector raw values")
    func rawValues() {
        #expect(BoardSectorType.center.rawValue == "center")
        #expect(BoardSectorType.edge.rawValue == "edge")
        #expect(BoardSectorType.corner.rawValue == "corner")
    }
}
