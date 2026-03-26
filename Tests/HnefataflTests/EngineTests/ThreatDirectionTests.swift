import Testing
@testable import Hnefatafl

@Suite("ThreatDirection Tests")
struct ThreatDirectionTests {

    @Test("piece with no threats has no directions")
    func noThreats() {
        let pos = PositionBuilder()
            .place(.defender, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let dirs = ThreatDirection.analyze(position: pos, row: 5, col: 5)
        #expect(dirs.isEmpty)
    }

    @Test("threat from north detected")
    func northThreat() {
        let pos = PositionBuilder()
            .place(.defender, row: 5, col: 5)
            .place(.attacker, row: 4, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let dirs = ThreatDirection.analyze(position: pos, row: 5, col: 5)
        #expect(dirs.contains(.north))
    }

    @Test("threat from south detected")
    func southThreat() {
        let pos = PositionBuilder()
            .place(.defender, row: 5, col: 5)
            .place(.attacker, row: 6, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let dirs = ThreatDirection.analyze(position: pos, row: 5, col: 5)
        #expect(dirs.contains(.south))
    }

    @Test("multiple threats detected")
    func multipleThreats() {
        let pos = PositionBuilder()
            .place(.defender, row: 5, col: 5)
            .place(.attacker, row: 4, col: 5)
            .place(.attacker, row: 5, col: 6)
            .place(.king, row: 0, col: 0)
            .build()
        let dirs = ThreatDirection.analyze(position: pos, row: 5, col: 5)
        #expect(dirs.count == 2)
    }

    @Test("CardinalDirection is Equatable")
    func equatable() {
        #expect(CardinalDirection.north == CardinalDirection.north)
        #expect(CardinalDirection.north != CardinalDirection.south)
    }

    @Test("empty square returns empty")
    func emptySquare() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 0)
            .build()
        let dirs = ThreatDirection.analyze(position: pos, row: 5, col: 5)
        #expect(dirs.isEmpty)
    }
}
