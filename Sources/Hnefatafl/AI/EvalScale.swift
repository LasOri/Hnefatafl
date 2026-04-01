
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(WASILibc)
import WASILibc
#endif

enum EvalScale {
    static let winScore = 10000
    static let drawScore = 0
    static let maxMaterialScore = 5000

    static func normalize(rawScore: Int, maxRange: Int = 1000) -> Int {
        guard maxRange > 0 else { return 0 }
        return max(-maxRange, min(maxRange, rawScore))
    }

    static func toWinProbability(score: Int) -> Double {
        let k = 0.004
        return 1.0 / (1.0 + exp(-k * Double(score)))
    }

    static func isDecisive(score: Int) -> Bool {
        abs(score) >= winScore / 2
    }
}
