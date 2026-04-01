
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(WASILibc)
import WASILibc
#endif

struct CaptureParticle: Equatable {
    let originRow: Int
    let originCol: Int
    let velocityX: Double
    let velocityY: Double
    let lifetime: Double
}

struct CaptureParticleSystem {
    static let cssClassName = "capture-particle"

    static func generate(at square: (row: Int, col: Int), count: Int = 8) -> [CaptureParticle] {
        (0..<count).map { i in
            let angle = Double(i) * (2.0 * Double.pi / Double(count))
            let speed = 1.0 + Double(i % 3) * 0.5
            return CaptureParticle(
                originRow: square.row,
                originCol: square.col,
                velocityX: cos(angle) * speed,
                velocityY: sin(angle) * speed,
                lifetime: 0.3 + Double(i % 3) * 0.1
            )
        }
    }
}
