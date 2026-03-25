import Testing
@testable import Hnefatafl

@Suite("MaterialCountEval Tests")
struct MaterialCountEvalTests {

    @Test("standard eval for start position")
    func standardEvalStart() {
        let pos = Position.copenhagenStart()
        let score = MaterialCountEval.standardEval(position: pos)
        #expect(score != 0)
    }

    @Test("evaluate with custom values")
    func customValues() {
        let pos = Position.copenhagenStart()
        let score = MaterialCountEval.evaluate(position: pos, attackerValue: 2, defenderValue: 3, kingValue: 10)
        #expect(score != 0)
    }

    @Test("empty board evaluates to zero")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = MaterialCountEval.evaluate(position: pos, attackerValue: 1, defenderValue: 1, kingValue: 3)
        #expect(score == 0)
    }

    @Test("more attackers means lower score")
    func moreAttackersLower() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[0] = .king
        cells1[1] = .attacker
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[0] = .king
        cells2[1] = .attacker
        cells2[2] = .attacker
        let pos2 = Position(cells: cells2)

        let s1 = MaterialCountEval.standardEval(position: pos1)
        let s2 = MaterialCountEval.standardEval(position: pos2)
        #expect(s1 > s2)
    }

    @Test("king value affects score")
    func kingValueAffects() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .attacker
        let pos = Position(cells: cells)
        let lowKing = MaterialCountEval.evaluate(position: pos, attackerValue: 1, defenderValue: 1, kingValue: 1)
        let highKing = MaterialCountEval.evaluate(position: pos, attackerValue: 1, defenderValue: 1, kingValue: 10)
        #expect(highKing > lowKing)
    }

    @Test("standard eval: defender advantage with king value 3")
    func standardDefenderAdvantage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let pos = Position(cells: cells)
        let score = MaterialCountEval.standardEval(position: pos)
        #expect(score == 3)
    }
}
