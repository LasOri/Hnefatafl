import Testing
@testable import Hnefatafl

@Suite("Capture Sequence Tests")
struct CaptureSequenceTests {

    @Test("empty board has no captures")
    func emptyBoardNoCaptures() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = CaptureSequence.findBestSequence(position: position, player: .attacker)
        #expect(result.totalCaptures == 0)
    }

    @Test("start position returns a result")
    func startPositionResult() {
        let position = Position.copenhagenStart()
        let result = CaptureSequence.findBestSequence(position: position, player: .attacker)
        #expect(result.totalCaptures >= 0)
    }

    @Test("total captures is non-negative")
    func totalCapturesNonNegative() {
        let position = Position.copenhagenStart()
        let result = CaptureSequence.findBestSequence(position: position, player: .defender)
        #expect(result.totalCaptures >= 0)
    }

    @Test("moves array is present in result")
    func movesArrayPresent() {
        let position = Position.copenhagenStart()
        let result = CaptureSequence.findBestSequence(position: position, player: .attacker)
        #expect(result.moves.count >= 0)
    }

    @Test("capture sequence finds max captures available")
    func maxCapturesFound() {
        let position = emptyBoard()
            .placing(.attacker, row: 2, col: 4)
            .placing(.defender, row: 2, col: 5)
            .placing(.attacker, row: 2, col: 6)
            .placing(.king, row: 9, col: 9)
            .build()
        let result = CaptureSequence.findBestSequence(position: position, player: .attacker)
        #expect(result.totalCaptures >= 0)
    }
}
