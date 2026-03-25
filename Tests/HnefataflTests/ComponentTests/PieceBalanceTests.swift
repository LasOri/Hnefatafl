import Testing
@testable import Hnefatafl

@Suite("Piece Balance Tests")
struct PieceBalanceTests {

    @Test("starting position balance")
    func startingBalance() {
        let position = Position.copenhagenStart()
        let balance = PieceBalance.compute(position: position)
        #expect(balance.attackers == 24)
        #expect(balance.defenders == 13)
        #expect(balance.hasKing)
    }

    @Test("ratio favors attacker in start")
    func ratioFavorsAttacker() {
        let position = Position.copenhagenStart()
        let balance = PieceBalance.compute(position: position)
        #expect(balance.ratio > 1.0)
    }

    @Test("empty board has zero ratio")
    func emptyRatio() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let balance = PieceBalance.compute(position: position)
        #expect(balance.ratio == 0)
    }

    @Test("advantage label for attacker")
    func attackerAdvantage() {
        let balance = PieceBalanceResult(attackers: 20, defenders: 5, hasKing: true)
        #expect(balance.advantageLabel.contains("Attacker"))
    }

    @Test("advantage label for defender")
    func defenderAdvantage() {
        let balance = PieceBalanceResult(attackers: 5, defenders: 10, hasKing: true)
        #expect(balance.advantageLabel.contains("Defender"))
    }

    @Test("equal balance label")
    func equalBalance() {
        let balance = PieceBalanceResult(attackers: 10, defenders: 10, hasKing: false)
        #expect(balance.advantageLabel.contains("Even"))
    }

    @Test("PieceBalanceResult is Equatable")
    func equatable() {
        let a = PieceBalanceResult(attackers: 10, defenders: 5, hasKing: true)
        let b = PieceBalanceResult(attackers: 10, defenders: 5, hasKing: true)
        #expect(a == b)
    }

    @Test("percentage for attacker")
    func percentage() {
        let balance = PieceBalanceResult(attackers: 20, defenders: 10, hasKing: true)
        #expect(balance.attackerPercentage == 66)
    }
}
