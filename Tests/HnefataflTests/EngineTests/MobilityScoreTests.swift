import Testing
@testable import Hnefatafl

@Suite("Mobility Score Tests")
struct MobilityScoreTests {

    @Test("starting position has moves for both sides")
    func startingMobility() {
        let position = Position.copenhagenStart()
        let score = MobilityScore.compute(position: position)
        #expect(score.attackerMoves > 0)
        #expect(score.defenderMoves > 0)
    }

    @Test("empty board has zero mobility")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let score = MobilityScore.compute(position: position)
        #expect(score.attackerMoves == 0)
        #expect(score.defenderMoves == 0)
    }

    @Test("ratio is positive when attacker has more moves")
    func positiveRatio() {
        let position = Position.copenhagenStart()
        let score = MobilityScore.compute(position: position)
        if score.attackerMoves > score.defenderMoves {
            #expect(score.ratio > 0)
        }
    }

    @Test("ratio is zero when equal moves")
    func zeroRatio() {
        let score = Mobility(attackerMoves: 10, defenderMoves: 10)
        #expect(score.ratio == 0)
    }

    @Test("ratio is negative when defender has more")
    func negativeRatio() {
        let score = Mobility(attackerMoves: 5, defenderMoves: 15)
        #expect(score.ratio < 0)
    }

    @Test("single attacker mobility count")
    func singleAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let score = MobilityScore.compute(position: position)
        #expect(score.attackerMoves > 0)
        #expect(score.defenderMoves == 0)
    }

    @Test("advantage returns correct side")
    func advantage() {
        let attAdv = Mobility(attackerMoves: 20, defenderMoves: 10)
        #expect(attAdv.advantage == .attacker)
        let defAdv = Mobility(attackerMoves: 10, defenderMoves: 20)
        #expect(defAdv.advantage == .defender)
        let equal = Mobility(attackerMoves: 10, defenderMoves: 10)
        #expect(equal.advantage == nil)
    }

    @Test("total moves sums both sides")
    func totalMoves() {
        let score = Mobility(attackerMoves: 15, defenderMoves: 25)
        #expect(score.totalMoves == 40)
    }
}
