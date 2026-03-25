import Testing
@testable import Hnefatafl

@Suite("NavigationArrow Tests")
struct NavigationArrowTests {

    @Test("forReplay with both enabled returns two arrows")
    func bothEnabledTwoArrows() {
        let arrows = NavigationArrow.forReplay(canBack: true, canForward: true)
        #expect(arrows.count == 2)
    }

    @Test("first arrow is left direction")
    func firstArrowLeft() {
        let arrows = NavigationArrow.forReplay(canBack: true, canForward: true)
        #expect(arrows[0].direction == .left)
        #expect(arrows[0].isEnabled == true)
    }

    @Test("second arrow is right direction")
    func secondArrowRight() {
        let arrows = NavigationArrow.forReplay(canBack: false, canForward: true)
        #expect(arrows[1].direction == .right)
        #expect(arrows[1].isEnabled == true)
    }

    @Test("canBack false disables left arrow")
    func canBackFalseDisablesLeft() {
        let arrows = NavigationArrow.forReplay(canBack: false, canForward: true)
        #expect(arrows[0].isEnabled == false)
    }

    @Test("canForward false disables right arrow")
    func canForwardFalseDisablesRight() {
        let arrows = NavigationArrow.forReplay(canBack: true, canForward: false)
        #expect(arrows[1].isEnabled == false)
    }

    @Test("ArrowDirection has four cases")
    func arrowDirectionFourCases() {
        #expect(ArrowDirection.allCases.count == 4)
        #expect(ArrowDirection.allCases.contains(.up))
        #expect(ArrowDirection.allCases.contains(.down))
        #expect(ArrowDirection.allCases.contains(.left))
        #expect(ArrowDirection.allCases.contains(.right))
    }

    @Test("arrows have labels")
    func arrowsHaveLabels() {
        let arrows = NavigationArrow.forReplay(canBack: true, canForward: true)
        #expect(!arrows[0].label.isEmpty)
        #expect(!arrows[1].label.isEmpty)
    }
}
