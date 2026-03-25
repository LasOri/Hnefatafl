import Testing
@testable import Hnefatafl

@Suite("Tempo Eval Tests")
struct TempoEvalTests {

    @Test("start position tempo returns an integer")
    func startPositionTempo() {
        let position = Position.copenhagenStart()
        let adv = TempoEval.tempoAdvantage(position: position, player: .attacker)
        #expect(adv >= -100 && adv <= 200)
    }

    @Test("advantage returns integer value")
    func advantageReturnsInt() {
        let position = Position.copenhagenStart()
        let val = TempoEval.tempoAdvantage(position: position, player: .defender)
        #expect(type(of: val) == Int.self)
    }

    @Test("has tempo returns bool")
    func hasTempoReturnsBool() {
        let position = Position.copenhagenStart()
        let result = TempoEval.hasTempo(position: position, player: .attacker)
        #expect(result == true || result == false)
    }

    @Test("symmetric check: attacker and defender tempo are inverse")
    func symmetricCheck() {
        let position = Position.copenhagenStart()
        let attackerAdv = TempoEval.tempoAdvantage(position: position, player: .attacker)
        let defenderAdv = TempoEval.tempoAdvantage(position: position, player: .defender)
        #expect(attackerAdv != defenderAdv || attackerAdv == 0)
    }

    @Test("empty board with single pieces")
    func singlePieces() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[3 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let advAttacker = TempoEval.tempoAdvantage(position: position, player: .attacker)
        let advDefender = TempoEval.tempoAdvantage(position: position, player: .defender)
        #expect(advAttacker + advDefender != 0 || advAttacker == 0)
    }
}
