import Testing
@testable import Hnefatafl

@Suite("Board Border Config Tests")
struct BoardBorderConfigTests {

    @Test("standard preset has shadow enabled")
    func standardHasShadow() {
        #expect(BoardBorderConfig.standard.showShadow)
    }

    @Test("minimal preset has no shadow")
    func minimalNoShadow() {
        #expect(!BoardBorderConfig.minimal.showShadow)
    }

    @Test("standard has larger width than minimal")
    func standardWiderThanMinimal() {
        #expect(BoardBorderConfig.standard.width > BoardBorderConfig.minimal.width)
    }

    @Test("standard has corner radius")
    func standardHasCornerRadius() {
        #expect(BoardBorderConfig.standard.cornerRadius > 0)
    }

    @Test("minimal has zero corner radius")
    func minimalZeroRadius() {
        #expect(BoardBorderConfig.minimal.cornerRadius == 0)
    }

    @Test("configs are equatable")
    func equatable() {
        let a = BoardBorderConfig.standard
        let b = BoardBorderConfig.standard
        #expect(a == b)
    }

    @Test("standard and minimal are not equal")
    func presetsNotEqual() {
        #expect(BoardBorderConfig.standard != BoardBorderConfig.minimal)
    }
}
