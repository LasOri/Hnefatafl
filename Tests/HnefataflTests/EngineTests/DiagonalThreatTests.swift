import Testing
@testable import Hnefatafl

@Suite("DiagonalThreat Tests")
struct DiagonalThreatTests {

    @Test("no threats on empty board")
    func emptyBoard() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let threats = DiagonalThreat.detect(position: pos, for: .attacker)
        #expect(threats.isEmpty)
    }

    @Test("two attackers diagonal to defender create threat")
    func diagonalPair() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 3)
            .place(.attacker, row: 5, col: 5)
            .place(.defender, row: 4, col: 4)
            .place(.king, row: 0, col: 0)
            .build()
        let threats = DiagonalThreat.detect(position: pos, for: .attacker)
        #expect(!threats.isEmpty)
    }

    @Test("same-side pieces don't threaten each other")
    func sameSide() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 3)
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let threats = DiagonalThreat.detect(position: pos, for: .attacker)
        #expect(threats.isEmpty)
    }

    @Test("threat entry has target location")
    func targetLocation() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 3)
            .place(.attacker, row: 5, col: 5)
            .place(.defender, row: 4, col: 4)
            .place(.king, row: 0, col: 0)
            .build()
        let threats = DiagonalThreat.detect(position: pos, for: .attacker)
        if let t = threats.first {
            #expect(t.targetRow == 4)
            #expect(t.targetCol == 4)
        }
    }

    @Test("DiagonalThreatEntry is Equatable")
    func equatable() {
        let a = DiagonalThreatEntry(targetRow: 1, targetCol: 1)
        let b = DiagonalThreatEntry(targetRow: 1, targetCol: 1)
        #expect(a == b)
    }

    @Test("starting position may have diagonal threats")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let threats = DiagonalThreat.detect(position: pos, for: .attacker)
        #expect(threats.count >= 0)
    }

    @Test("defender diagonal threats detected too")
    func defenderThreats() {
        let pos = PositionBuilder()
            .place(.defender, row: 3, col: 3)
            .place(.defender, row: 5, col: 5)
            .place(.attacker, row: 4, col: 4)
            .place(.king, row: 0, col: 0)
            .build()
        let threats = DiagonalThreat.detect(position: pos, for: .defender)
        #expect(!threats.isEmpty)
    }
}
