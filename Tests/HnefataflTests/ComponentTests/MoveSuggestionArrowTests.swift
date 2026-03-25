import Testing
@testable import Hnefatafl

@Suite("MoveSuggestionArrow Tests")
struct MoveSuggestionArrowTests {
    @Test("Creates arrow config")
    func createArrow() {
        let arrow = ArrowConfig(from: (5, 5), to: (5, 7), color: "green", width: 3.0)
        #expect(arrow.from == (5, 5))
        #expect(arrow.to == (5, 7))
        #expect(arrow.color == "green")
        #expect(arrow.width == 3.0)
    }

    @Test("Generates CSS style for horizontal arrow")
    func horizontalArrowStyle() {
        let arrow = ArrowConfig(from: (5, 5), to: (5, 7), color: "blue", width: 2.0)
        let style = arrow.cssStyle
        #expect(style.contains("blue"))
        #expect(style.contains("2.0"))
    }

    @Test("Generates CSS style for vertical arrow")
    func verticalArrowStyle() {
        let arrow = ArrowConfig(from: (3, 4), to: (6, 4), color: "red", width: 4.0)
        let style = arrow.cssStyle
        #expect(style.contains("red"))
        #expect(style.contains("4.0"))
    }

    @Test("Generates CSS style for diagonal arrow")
    func diagonalArrowStyle() {
        let arrow = ArrowConfig(from: (0, 0), to: (3, 3), color: "yellow", width: 1.5)
        let style = arrow.cssStyle
        #expect(style.contains("yellow"))
        #expect(style.contains("1.5"))
    }

    @Test("Arrow config is equatable")
    func arrowEquatable() {
        let arrow1 = ArrowConfig(from: (1, 2), to: (3, 4), color: "green", width: 2.0)
        let arrow2 = ArrowConfig(from: (1, 2), to: (3, 4), color: "green", width: 2.0)
        #expect(arrow1 == arrow2)
    }

    @Test("Different arrows are not equal")
    func differentArrows() {
        let arrow1 = ArrowConfig(from: (1, 2), to: (3, 4), color: "green", width: 2.0)
        let arrow2 = ArrowConfig(from: (1, 2), to: (3, 5), color: "green", width: 2.0)
        #expect(arrow1 != arrow2)
    }
}
