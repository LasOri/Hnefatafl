import Testing
@testable import Hnefatafl

@Suite("Board Heatmap Tests")
struct BoardHeatmapTests {

    @Test("heatmap has 121 entries")
    func entryCount() {
        let position = Position.copenhagenStart()
        let heatmap = BoardHeatmap.generate(position: position, for: .attacker)
        #expect(heatmap.values.count == 121)
    }

    @Test("values normalized to 0-1")
    func normalized() {
        let position = Position.copenhagenStart()
        let heatmap = BoardHeatmap.generate(position: position, for: .attacker)
        for value in heatmap.values {
            #expect(value >= 0.0 && value <= 1.0)
        }
    }

    @Test("empty board all zeros")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let heatmap = BoardHeatmap.generate(position: position, for: .attacker)
        #expect(heatmap.values.allSatisfy { $0 == 0.0 })
    }

    @Test("color for cold value")
    func coldColor() {
        let color = BoardHeatmap.color(for: 0.0)
        #expect(color.contains("0"))
    }

    @Test("color for hot value")
    func hotColor() {
        let color = BoardHeatmap.color(for: 1.0)
        #expect(!color.isEmpty)
    }

    @Test("Heatmap is Equatable")
    func equatable() {
        let a = Heatmap(values: [0.0, 0.5, 1.0])
        let b = Heatmap(values: [0.0, 0.5, 1.0])
        #expect(a == b)
    }

    @Test("defender heatmap differs from attacker")
    func differentSides() {
        let position = Position.copenhagenStart()
        let attacker = BoardHeatmap.generate(position: position, for: .attacker)
        let defender = BoardHeatmap.generate(position: position, for: .defender)
        #expect(attacker != defender)
    }

    @Test("max value in heatmap")
    func maxValue() {
        let position = Position.copenhagenStart()
        let heatmap = BoardHeatmap.generate(position: position, for: .attacker)
        #expect(heatmap.maxValue >= 0.0)
    }
}
