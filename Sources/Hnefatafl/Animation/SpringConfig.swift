import LINKER

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(WASILibc)
import WASILibc
#endif

struct SpringConfig: Equatable {
    let stiffness: Double
    let damping: Double
    let mass: Double

    init(stiffness: Double = 300, damping: Double = 20, mass: Double = 1.0) {
        self.stiffness = stiffness
        self.damping = damping
        self.mass = mass
    }

    var naturalFrequency: Double {
        sqrt(stiffness / mass)
    }

    var dampingRatio: Double {
        damping / (2.0 * sqrt(stiffness * mass))
    }

    var isUnderdamped: Bool {
        dampingRatio < 1.0
    }

    var settlingTime: Double {
        let omega = naturalFrequency
        let zeta = dampingRatio
        guard zeta > 0 && omega > 0 else { return 1.0 }
        return 4.0 / (zeta * omega)
    }

    func cssTransition(property: String) -> String {
        let duration = settlingTime
        return "\(property) \(formatDecimal(duration, decimals: 2))s ease-out"
    }

    static let gentle = SpringConfig(stiffness: 120, damping: 14)
    static let wobbly = SpringConfig(stiffness: 180, damping: 12)
    static let stiff = SpringConfig(stiffness: 400, damping: 28)
    static let slow = SpringConfig(stiffness: 80, damping: 16)
    static let snappy = SpringConfig(stiffness: 500, damping: 25)
}

struct Spring {
    let config: SpringConfig

    func position(at time: Double, from start: Double, to end: Double) -> Double {
        let distance = end - start
        guard distance != 0, time > 0 else { return start }

        let omega = sqrt(config.stiffness)
        let zeta = config.damping / (2.0 * omega)
        let omegaD = omega * sqrt(max(1.0 - zeta * zeta, 0.001))

        let decay = exp(-zeta * omega * time)
        let cosine = cos(omegaD * time)
        let sine = sin(omegaD * time)
        let factor = 1.0 - decay * (cosine + (zeta * omega / omegaD) * sine)

        return start + distance * factor
    }

    func isSettled(at time: Double, from start: Double, to end: Double, threshold: Double = 0.01) -> Bool {
        let current = position(at: time, from: start, to: end)
        return abs(current - end) < threshold
    }
}
