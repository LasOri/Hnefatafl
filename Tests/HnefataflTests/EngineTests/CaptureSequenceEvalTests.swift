import Testing
@testable import Hnefatafl

@Suite("CaptureSequenceEval Tests")
struct CaptureSequenceEvalTests {

    @Test("empty board has zero max sequence")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let len = CaptureSequenceEval.maxSequenceLength(position: pos, player: .attacker)
        #expect(len == 0)
    }

    @Test("no combo when no captures possible")
    func noCombo() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[10] = .king
        let pos = Position(cells: cells)
        let has = CaptureSequenceEval.hasCombo(position: pos, player: .attacker)
        #expect(has == false)
    }

    @Test("hasCombo is false when max sequence is 1")
    func singleCaptureNoCombo() {
        let pos = Position.copenhagenStart()
        let len = CaptureSequenceEval.maxSequenceLength(position: pos, player: .attacker)
        if len < 2 {
            #expect(CaptureSequenceEval.hasCombo(position: pos, player: .attacker) == false)
        } else {
            #expect(CaptureSequenceEval.hasCombo(position: pos, player: .attacker) == true)
        }
    }

    @Test("max sequence length is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let len = CaptureSequenceEval.maxSequenceLength(position: pos, player: .attacker)
        #expect(len >= 0)
    }

    @Test("defender sequence also works")
    func defenderSequence() {
        let pos = Position.copenhagenStart()
        let len = CaptureSequenceEval.maxSequenceLength(position: pos, player: .defender)
        #expect(len >= 0)
    }

    @Test("hasCombo consistent with maxSequenceLength")
    func comboConsistency() {
        let pos = Position.copenhagenStart()
        let len = CaptureSequenceEval.maxSequenceLength(position: pos, player: .attacker)
        let has = CaptureSequenceEval.hasCombo(position: pos, player: .attacker)
        #expect(has == (len >= 2))
    }
}
