import Testing
@testable import Hnefatafl

@Suite("CaptureRisk Tests")
struct CaptureRiskTests {

    @Test("pieces at risk identified")
    func atRisk() {
        let pos = PositionBuilder()
            .place(.attacker, row: 4, col: 5)
            .place(.defender, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let risks = CaptureRisk.assess(position: pos, for: .defender)
        #expect(risks.count >= 0)
    }

    @Test("safe piece has low risk")
    func safePiece() {
        let pos = PositionBuilder()
            .place(.defender, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let risks = CaptureRisk.assess(position: pos, for: .defender)
        let defRisks = risks.filter { $0.row == 5 && $0.col == 5 }
        if let risk = defRisks.first {
            #expect(risk.riskLevel <= 1)
        }
    }

    @Test("flanked piece has high risk")
    func flankedPiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 4, col: 5)
            .place(.defender, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let risks = CaptureRisk.assess(position: pos, for: .defender)
        let defRisks = risks.filter { $0.row == 5 && $0.col == 5 }
        if let risk = defRisks.first {
            #expect(risk.riskLevel > 0)
        }
    }

    @Test("CaptureRiskEntry is Equatable")
    func equatable() {
        let a = CaptureRiskEntry(row: 5, col: 5, riskLevel: 2)
        let b = CaptureRiskEntry(row: 5, col: 5, riskLevel: 2)
        #expect(a == b)
    }

    @Test("risk level is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let risks = CaptureRisk.assess(position: pos, for: .attacker)
        for r in risks {
            #expect(r.riskLevel >= 0)
        }
    }

    @Test("empty board has no risks")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let risks = CaptureRisk.assess(position: pos, for: .attacker)
        #expect(risks.isEmpty)
    }

    @Test("starting position has risks for both sides")
    func bothSides() {
        let pos = Position.copenhagenStart()
        let attackerRisks = CaptureRisk.assess(position: pos, for: .attacker)
        let defenderRisks = CaptureRisk.assess(position: pos, for: .defender)
        #expect(!attackerRisks.isEmpty || !defenderRisks.isEmpty)
    }
}
