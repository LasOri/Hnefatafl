import Foundation

struct EvalBar {
    static func normalize(score: Int) -> Double {
        let clamped = max(-10000, min(10000, score))
        return tanh(Double(clamped) / 500.0)
    }

    static func percentage(normalizedValue: Double) -> Int {
        Int((normalizedValue + 1.0) / 2.0 * 100.0)
    }

    static func label(normalizedValue: Double) -> String {
        if normalizedValue > 0.05 { return "Attacker advantage" }
        if normalizedValue < -0.05 { return "Defender advantage" }
        return "Equal position"
    }

    static func evaluate(game: Game) -> Int {
        EvaluationAI.evaluate(position: game.position, for: .attacker)
    }
}
