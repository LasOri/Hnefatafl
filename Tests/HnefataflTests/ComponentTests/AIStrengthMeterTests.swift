import Testing
@testable import Hnefatafl

@Suite("AIStrengthMeter Tests")
struct AIStrengthMeterTests {
    @Test("Creates meter from depth and personality")
    func createMeter() {
        let meter = AIStrengthMeter(depth: 4, personality: .aggressive)
        #expect(meter.depth == 4)
        #expect(meter.personality == .aggressive)
    }

    @Test("Calculates level for beginner")
    func beginnerLevel() {
        let meter = AIStrengthMeter(depth: 2, personality: .defensive)
        #expect(meter.level == 1)
    }

    @Test("Calculates level for intermediate")
    func intermediateLevel() {
        let meter = AIStrengthMeter(depth: 4, personality: .balanced)
        #expect(meter.level == 2)
    }

    @Test("Calculates level for advanced")
    func advancedLevel() {
        let meter = AIStrengthMeter(depth: 6, personality: .aggressive)
        #expect(meter.level == 3)
    }

    @Test("Generates label")
    func label() {
        let meter = AIStrengthMeter(depth: 4, personality: .balanced)
        #expect(meter.label.contains("Level"))
    }

    @Test("Calculates percentage")
    func percentage() {
        let meter = AIStrengthMeter(depth: 4, personality: .balanced)
        let pct = meter.percentage
        #expect(pct > 0 && pct <= 100)
    }
}
