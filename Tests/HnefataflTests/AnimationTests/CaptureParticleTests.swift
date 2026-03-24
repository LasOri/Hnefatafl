import Testing
@testable import Hnefatafl

@Suite("Capture Particle Tests")
struct CaptureParticleTests {

    @Test("particle system generates particles")
    func generatesParticles() {
        let particles = CaptureParticleSystem.generate(at: (row: 5, col: 5), count: 8)
        #expect(particles.count == 8)
    }

    @Test("particles have position offsets")
    func positionOffsets() {
        let particles = CaptureParticleSystem.generate(at: (row: 3, col: 4), count: 4)
        for p in particles {
            #expect(p.originRow == 3)
            #expect(p.originCol == 4)
        }
    }

    @Test("particles have velocity")
    func velocity() {
        let particles = CaptureParticleSystem.generate(at: (row: 0, col: 0), count: 6)
        let hasVelocity = particles.contains { $0.velocityX != 0 || $0.velocityY != 0 }
        #expect(hasVelocity)
    }

    @Test("particles have lifetime")
    func lifetime() {
        let particles = CaptureParticleSystem.generate(at: (row: 5, col: 5), count: 4)
        for p in particles {
            #expect(p.lifetime > 0)
        }
    }

    @Test("default count is 8")
    func defaultCount() {
        let particles = CaptureParticleSystem.generate(at: (row: 0, col: 0))
        #expect(particles.count == 8)
    }

    @Test("particle CSS class")
    func cssClass() {
        #expect(!CaptureParticleSystem.cssClassName.isEmpty)
    }

    @Test("particles spread in different directions")
    func spread() {
        let particles = CaptureParticleSystem.generate(at: (row: 5, col: 5), count: 8)
        let uniqueAngles = Set(particles.map { "\($0.velocityX > 0),\($0.velocityY > 0)" })
        #expect(uniqueAngles.count >= 2)
    }

    @Test("Particle is Equatable")
    func equatable() {
        let a = CaptureParticle(originRow: 1, originCol: 2, velocityX: 0.5, velocityY: -0.5, lifetime: 0.3)
        let b = CaptureParticle(originRow: 1, originCol: 2, velocityX: 0.5, velocityY: -0.5, lifetime: 0.3)
        #expect(a == b)
    }
}
