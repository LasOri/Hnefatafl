import Testing
@testable import Hnefatafl

@Suite("Spring Config Tests")
struct SpringConfigTests {

    @Test("SpringConfig has stiffness and damping")
    func springConfig_hasProperties() {
        let config = SpringConfig(stiffness: 200, damping: 20)

        #expect(config.stiffness == 200)
        #expect(config.damping == 20)
    }

    @Test("gentle preset has low stiffness")
    func gentle_hasLowStiffness() {
        let config = SpringConfig.gentle

        #expect(config.stiffness < 150)
        #expect(config.damping > 0)
    }

    @Test("stiff preset has high stiffness")
    func stiff_hasHighStiffness() {
        let config = SpringConfig.stiff

        #expect(config.stiffness > 300)
    }

    @Test("wobbly preset has low damping ratio")
    func wobbly_hasLowDamping() {
        let config = SpringConfig.wobbly

        #expect(config.damping < config.stiffness)
    }

    @Test("Spring computes position from config and time")
    func spring_computesPosition() {
        let spring = Spring(config: .gentle)
        let position = spring.position(at: 0.0, from: 0.0, to: 1.0)

        #expect(position == 0.0)
    }

    @Test("Spring reaches target at large time value")
    func spring_reachesTarget() {
        let spring = Spring(config: .gentle)
        let position = spring.position(at: 5.0, from: 0.0, to: 1.0)

        #expect(abs(position - 1.0) < 0.01)
    }

    @Test("Spring at midpoint is between start and end")
    func spring_midpointBetween() {
        let spring = Spring(config: .gentle)
        let position = spring.position(at: 0.1, from: 0.0, to: 1.0)

        #expect(position > 0.0)
        #expect(position <= 1.2)
    }

    @Test("Spring with equal start and end returns target")
    func spring_equalStartEnd() {
        let spring = Spring(config: .gentle)
        let position = spring.position(at: 0.5, from: 5.0, to: 5.0)

        #expect(position == 5.0)
    }

    @Test("Spring with different start and end values")
    func spring_differentRange() {
        let spring = Spring(config: .stiff)
        let position = spring.position(at: 5.0, from: 10.0, to: 20.0)

        #expect(abs(position - 20.0) < 0.1)
    }

    @Test("isSettled returns false at start")
    func spring_notSettledAtStart() {
        let spring = Spring(config: .gentle)
        let settled = spring.isSettled(at: 0.01, from: 0.0, to: 1.0)

        #expect(!settled)
    }

    @Test("isSettled returns true after enough time")
    func spring_settledAfterTime() {
        let spring = Spring(config: .stiff)
        let settled = spring.isSettled(at: 5.0, from: 0.0, to: 1.0)

        #expect(settled)
    }
}
