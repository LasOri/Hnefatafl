import Testing
@testable import Hnefatafl

@Suite("Territory Analyzer Tests")
struct TerritoryAnalyzerTests {

    @Test("analyzes starting position without crash")
    func analyzesStarting() {
        let position = Position.copenhagenStart()
        let control = TerritoryAnalyzer.analyze(position: position)
        #expect(control.count == Position.boardSize * Position.boardSize)
    }

    @Test("control values range from -1 to 1")
    func controlRange() {
        let position = Position.copenhagenStart()
        let control = TerritoryAnalyzer.analyze(position: position)
        for value in control {
            #expect(value >= -1.0 && value <= 1.0)
        }
    }

    @Test("empty board has zero control")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let control = TerritoryAnalyzer.analyze(position: position)
        for value in control {
            #expect(value == 0.0)
        }
    }

    @Test("attacker near square gives positive control")
    func attackerControl() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let control = TerritoryAnalyzer.analyze(position: position)
        let centerIdx = 5 * 11 + 5
        #expect(control[centerIdx] > 0)
    }

    @Test("defender near square gives negative control")
    func defenderControl() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let control = TerritoryAnalyzer.analyze(position: position)
        let centerIdx = 5 * 11 + 5
        #expect(control[centerIdx] < 0)
    }

    @Test("king contributes to defender control")
    func kingControl() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let control = TerritoryAnalyzer.analyze(position: position)
        let centerIdx = 5 * 11 + 5
        #expect(control[centerIdx] < 0)
    }

    @Test("attacker percentage for starting position")
    func attackerPercentage() {
        let position = Position.copenhagenStart()
        let pct = TerritoryAnalyzer.attackerPercentage(position: position)
        #expect(pct > 0 && pct < 100)
    }

    @Test("control influence diminishes with distance")
    func influenceDiminishes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let control = TerritoryAnalyzer.analyze(position: position)
        let adjacent = control[5 * 11 + 6]
        let farther = control[5 * 11 + 8]
        #expect(adjacent >= farther)
    }
}
