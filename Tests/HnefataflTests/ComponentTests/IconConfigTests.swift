import Testing
@testable import Hnefatafl

@Suite("IconConfig Tests")
struct IconConfigTests {
    @Test("Standard preset size is 32")
    func standardSize() {
        #expect(IconConfig.standard.size == 32)
    }

    @Test("Large preset size is 48")
    func largeSize() {
        #expect(IconConfig.large.size == 48)
    }

    @Test("Standard has no shadow")
    func standardNoShadow() {
        #expect(!IconConfig.standard.showShadow)
    }

    @Test("Large has shadow")
    func largeHasShadow() {
        #expect(IconConfig.large.showShadow)
    }

    @Test("Standard style is flat")
    func standardStyle() {
        #expect(IconConfig.standard.style == "flat")
    }

    @Test("Large style is detailed")
    func largeStyle() {
        #expect(IconConfig.large.style == "detailed")
    }

    @Test("Configs are equatable")
    func equatable() {
        let a = IconConfig.standard
        let b = IconConfig.standard
        #expect(a == b)
        #expect(IconConfig.standard != IconConfig.large)
    }
}
