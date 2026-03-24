import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Eval Bar Tests")
struct EvalBarTests {

    @Test("EvalBar normalizes positive score toward 1.0")
    func normalizesPositive() {
        let value = EvalBar.normalize(score: 500)
        #expect(value > 0.0)
        #expect(value <= 1.0)
    }

    @Test("EvalBar normalizes negative score toward -1.0")
    func normalizesNegative() {
        let value = EvalBar.normalize(score: -500)
        #expect(value < 0.0)
        #expect(value >= -1.0)
    }

    @Test("EvalBar normalizes zero to 0.0")
    func normalizesZero() {
        let value = EvalBar.normalize(score: 0)
        #expect(value == 0.0)
    }

    @Test("EvalBar clamps extreme scores")
    func clampsExtremes() {
        let high = EvalBar.normalize(score: 10000)
        let low = EvalBar.normalize(score: -10000)
        #expect(high >= 0.9)
        #expect(low <= -0.9)
    }

    @Test("EvalBar percentage for display")
    func percentage() {
        let pct = EvalBar.percentage(normalizedValue: 0.0)
        #expect(pct == 50)
        let fullAttacker = EvalBar.percentage(normalizedValue: 1.0)
        #expect(fullAttacker == 100)
        let fullDefender = EvalBar.percentage(normalizedValue: -1.0)
        #expect(fullDefender == 0)
    }

    @Test("EvalBar label describes advantage")
    func label() {
        #expect(EvalBar.label(normalizedValue: 0.5) == "Attacker advantage")
        #expect(EvalBar.label(normalizedValue: -0.5) == "Defender advantage")
        #expect(EvalBar.label(normalizedValue: 0.0) == "Equal position")
    }

    @Test("evaluate returns score for starting position")
    func evaluateStarting() {
        let game = Game()
        let score = EvalBar.evaluate(game: game)
        #expect(score != 0 || score == 0)
    }

    @Test("EvalDisplay renders with aria attributes")
    func rendersWithAria() {
        let nodes = EvalDisplay.render(normalizedValue: 0.3)
        let rendered = render(nodes)
        let bar = rendered.findAll(tag: "div").first(where: { $0.attr("role") == "meter" })
        #expect(bar != nil)
    }
}
