import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Clock Display Tests")
struct ClockDisplayTests {

    @Test("renders attacker and defender times")
    func rendersTimes() {
        let timer = GameTimer(config: .standard)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let text = rendered.findByText("15:00")
        #expect(text != nil)
    }

    @Test("highlights active player clock")
    func highlightsActive() {
        let timer = GameTimer(config: .standard)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let active = rendered.findAll(tag: "span").first(where: { $0.className?.contains("clock-active") == true })
        #expect(active != nil)
    }

    @Test("shows low-time warning")
    func lowTimeWarning() {
        let timer = GameTimer(config: .blitz, attackerSeconds: 25, defenderSeconds: 300)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let warning = rendered.findAll(tag: "span").first(where: { $0.className?.contains("clock-low") == true })
        #expect(warning != nil)
    }

    @Test("no warning when time is sufficient")
    func noWarning() {
        let timer = GameTimer(config: .standard)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let warning = rendered.findAll(tag: "span").first(where: { $0.className?.contains("clock-low") == true })
        #expect(warning == nil)
    }

    @Test("low-time threshold is 30 seconds")
    func threshold() {
        #expect(ClockDisplay.lowTimeThreshold == 30)
    }

    @Test("renders nothing when timer disabled")
    func disabledTimer() {
        let timer = GameTimer(config: .none)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        #expect(nodes.isEmpty)
    }

    @Test("displays both player labels")
    func playerLabels() {
        let timer = GameTimer(config: .standard)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let attLabel = rendered.findByText("Attacker")
        let defLabel = rendered.findByText("Defender")
        #expect(attLabel != nil)
        #expect(defLabel != nil)
    }

    @Test("formats time correctly for low values")
    func formatsLowTime() {
        let timer = GameTimer(config: .blitz, attackerSeconds: 5, defenderSeconds: 0)
        let nodes = ClockDisplay.render(timer: timer, activePlayer: .attacker)
        let rendered = render(nodes)
        let zeroTime = rendered.findByText("0:00")
        #expect(zeroTime != nil)
    }
}
