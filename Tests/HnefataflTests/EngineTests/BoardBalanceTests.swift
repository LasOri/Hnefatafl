import Testing
@testable import Hnefatafl

@Suite("BoardBalance Tests")
struct BoardBalanceTests {

    @Test("starting position has material counts")
    func startMaterial() {
        let pos = Position.copenhagenStart()
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.attackerCount == 24)
        #expect(balance.defenderCount == 13)
    }

    @Test("material advantage is attacker at start")
    func attackerAdvantage() {
        let pos = Position.copenhagenStart()
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.materialAdvantage > 0)
    }

    @Test("empty board has zero balance")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let pos = Position(cells: cells)
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.attackerCount == 0)
        #expect(balance.defenderCount == 0)
    }

    @Test("balance score is computed")
    func balanceScore() {
        let pos = Position.copenhagenStart()
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.score != 0)
    }

    @Test("BalanceResult is Equatable")
    func equatable() {
        let a = BalanceResult(attackerCount: 1, defenderCount: 1, materialAdvantage: 0, score: 0)
        let b = BalanceResult(attackerCount: 1, defenderCount: 1, materialAdvantage: 0, score: 0)
        #expect(a == b)
    }

    @Test("king counts as defender")
    func kingAsDefender() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.defenderCount == 1)
    }

    @Test("material advantage is positive when more attackers")
    func materialAdvantageSign() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 1)
            .place(.attacker, row: 0, col: 2)
            .place(.king, row: 5, col: 5)
            .build()
        let balance = BoardBalance.evaluate(position: pos)
        #expect(balance.materialAdvantage > 0)
    }
}
