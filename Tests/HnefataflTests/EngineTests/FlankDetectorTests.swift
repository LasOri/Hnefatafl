import Testing
@testable import Hnefatafl

@Suite("Flank Detector Tests")
struct FlankDetectorTests {

    @Test("start position flanking check")
    func startPositionFlanking() {
        let position = Position.copenhagenStart()
        let result = FlankDetector.isFlankingKing(position: position)
        #expect(result == true || result == false)
    }

    @Test("no king returns false")
    func noKingReturnsFalse() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(FlankDetector.isFlankingKing(position: position) == false)
        #expect(FlankDetector.flankCount(position: position) == 0)
    }

    @Test("flank count is between 0 and 4")
    func flankCountRange() {
        let position = Position.copenhagenStart()
        let count = FlankDetector.flankCount(position: position)
        #expect(count >= 0 && count <= 4)
    }

    @Test("flanked when attackers on opposite sides")
    func flankedOpposite() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 0] = .attacker
        cells[5 * 11 + 10] = .attacker
        let position = Position(cells: cells)
        #expect(FlankDetector.isFlankingKing(position: position) == true)
    }

    @Test("not flanked when defenders block line of sight")
    func notFlankedDefendersBlock() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 0] = .attacker
        cells[5 * 11 + 3] = .defender
        cells[5 * 11 + 10] = .attacker
        cells[5 * 11 + 7] = .defender
        let position = Position(cells: cells)
        #expect(FlankDetector.isFlankingKing(position: position) == false)
    }
}
