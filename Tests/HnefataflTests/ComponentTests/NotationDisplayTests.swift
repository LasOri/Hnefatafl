import Testing
@testable import Hnefatafl

@Suite("NotationDisplay Tests")
struct NotationDisplayTests {

    @Test("default values")
    func defaultValues() {
        let display = NotationDisplay()
        #expect(display.style == .algebraic)
        #expect(display.showMoveNumbers == true)
        #expect(display.highlightLast == true)
    }

    @Test("custom style")
    func customStyle() {
        let display = NotationDisplay(style: .coordinate, showMoveNumbers: false, highlightLast: false)
        #expect(display.style == .coordinate)
        #expect(display.showMoveNumbers == false)
        #expect(display.highlightLast == false)
    }

    @Test("notation style cases")
    func notationStyleCases() {
        let cases = NotationStyle.allCases
        #expect(cases.count == 3)
        #expect(cases.contains(.algebraic))
        #expect(cases.contains(.coordinate))
        #expect(cases.contains(.descriptive))
    }

    @Test("notation style raw values")
    func rawValues() {
        #expect(NotationStyle.algebraic.rawValue == "algebraic")
        #expect(NotationStyle.coordinate.rawValue == "coordinate")
        #expect(NotationStyle.descriptive.rawValue == "descriptive")
    }

    @Test("equatable conformance")
    func equatable() {
        let a = NotationDisplay(style: .algebraic, showMoveNumbers: true, highlightLast: true)
        let b = NotationDisplay(style: .algebraic, showMoveNumbers: true, highlightLast: true)
        let c = NotationDisplay(style: .descriptive, showMoveNumbers: true, highlightLast: true)
        #expect(a == b)
        #expect(a != c)
    }

    @Test("descriptive style")
    func descriptiveStyle() {
        let display = NotationDisplay(style: .descriptive)
        #expect(display.style == .descriptive)
        #expect(display.showMoveNumbers == true)
    }
}
