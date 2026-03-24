import Testing
@testable import Hnefatafl

@Suite("Spring Animation Tests")
struct SpringAnimationTests {

    @Test("SpringConfig has default values")
    func defaults() {
        let config = SpringConfig()
        #expect(config.stiffness == 300)
        #expect(config.damping == 20)
        #expect(config.mass == 1.0)
    }

    @Test("SpringConfig computes natural frequency")
    func naturalFrequency() {
        let config = SpringConfig(stiffness: 400, damping: 20, mass: 1.0)
        let omega = config.naturalFrequency
        #expect(omega > 0)
        #expect(abs(omega - 20.0) < 0.1)
    }

    @Test("SpringConfig computes damping ratio")
    func dampingRatio() {
        let config = SpringConfig(stiffness: 100, damping: 20, mass: 1.0)
        let ratio = config.dampingRatio
        #expect(ratio == 1.0)
    }

    @Test("underdamped has ratio < 1")
    func underdamped() {
        let config = SpringConfig(stiffness: 300, damping: 10, mass: 1.0)
        #expect(config.dampingRatio < 1.0)
        #expect(config.isUnderdamped)
    }

    @Test("overdamped has ratio > 1")
    func overdamped() {
        let config = SpringConfig(stiffness: 100, damping: 30, mass: 1.0)
        #expect(config.dampingRatio > 1.0)
        #expect(!config.isUnderdamped)
    }

    @Test("settling time is positive")
    func settlingTime() {
        let config = SpringConfig()
        #expect(config.settlingTime > 0)
    }

    @Test("stiffer spring settles faster")
    func stifferFaster() {
        let soft = SpringConfig(stiffness: 100, damping: 20, mass: 1.0)
        let stiff = SpringConfig(stiffness: 400, damping: 40, mass: 1.0)
        #expect(stiff.settlingTime < soft.settlingTime)
    }

    @Test("CSS transition string generation")
    func cssTransition() {
        let config = SpringConfig()
        let css = config.cssTransition(property: "transform")
        #expect(css.contains("transform"))
        #expect(css.contains("s"))
    }

    @Test("preset snappy config")
    func presetSnappy() {
        let config = SpringConfig.snappy
        #expect(config.stiffness > SpringConfig().stiffness)
    }

    @Test("preset gentle config")
    func presetGentle() {
        let config = SpringConfig.gentle
        #expect(config.stiffness < SpringConfig().stiffness)
    }
}
