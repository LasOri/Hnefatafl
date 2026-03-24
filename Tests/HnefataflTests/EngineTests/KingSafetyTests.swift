import Testing
@testable import Hnefatafl

@Suite("King Safety Tests")
struct KingSafetyTests {

    @Test("king in starting position is safe")
    func startingSafe() {
        let position = Position.copenhagenStart()
        let safety = KingSafety.analyze(position: position)
        #expect(safety.dangerLevel == .safe)
    }

    @Test("counts adjacent threats")
    func countsThreats() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.adjacentThreats == 2)
    }

    @Test("danger level is critical with 3 threats")
    func criticalWith3() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.dangerLevel == .critical)
    }

    @Test("danger level is warning with 2 threats")
    func warningWith2() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        cells[4 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.dangerLevel == .warning)
    }

    @Test("counts escape routes")
    func countsEscapes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.escapeRoutes > 0)
    }

    @Test("escape routes blocked by pieces")
    func blockedEscapes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.escapeRoutes == 0)
    }

    @Test("returns safe when no king")
    func noKing() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let safety = KingSafety.analyze(position: position)
        #expect(safety.dangerLevel == .safe)
    }

    @Test("DangerLevel has all cases")
    func dangerLevelCases() {
        let cases: [DangerLevel] = [.safe, .warning, .critical]
        #expect(cases.count == 3)
    }
}
