import Testing
@testable import Hnefatafl

@Suite("BoardLabelConfig Tests")
struct BoardLabelConfigTests {
    @Test("Standard preset shows rows and cols")
    func standardShowsLabels() {
        #expect(BoardLabelConfig.standard.showRows)
        #expect(BoardLabelConfig.standard.showCols)
    }

    @Test("Hidden preset hides rows and cols")
    func hiddenHidesLabels() {
        #expect(!BoardLabelConfig.hidden.showRows)
        #expect(!BoardLabelConfig.hidden.showCols)
    }

    @Test("Standard has font size 12")
    func standardFontSize() {
        #expect(BoardLabelConfig.standard.fontSize == 12)
    }

    @Test("Standard position is outside")
    func standardPosition() {
        #expect(BoardLabelConfig.standard.position == "outside")
    }

    @Test("Configs are equatable")
    func equatable() {
        let a = BoardLabelConfig.standard
        let b = BoardLabelConfig.standard
        #expect(a == b)
    }

    @Test("Standard and hidden are not equal")
    func presetsNotEqual() {
        #expect(BoardLabelConfig.standard != BoardLabelConfig.hidden)
    }

    @Test("Custom config can be created")
    func customConfig() {
        let config = BoardLabelConfig(showRows: true, showCols: false, fontSize: 16, position: "inside")
        #expect(config.showRows)
        #expect(!config.showCols)
        #expect(config.fontSize == 16)
    }
}
