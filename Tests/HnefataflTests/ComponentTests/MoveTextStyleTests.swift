import Testing
@testable import Hnefatafl

@Suite("MoveTextStyle Tests")
struct MoveTextStyleTests {

    @Test("standard preset has correct fontSize")
    func standardFontSize() {
        #expect(MoveTextStyle.standard.fontSize == 14)
    }

    @Test("compact preset has smaller fontSize")
    func compactFontSize() {
        #expect(MoveTextStyle.compact.fontSize == 11)
    }

    @Test("highlighted preset is bold")
    func highlightedIsBold() {
        #expect(MoveTextStyle.highlighted.bold == true)
    }

    @Test("standard preset is not bold")
    func standardNotBold() {
        #expect(MoveTextStyle.standard.bold == false)
    }

    @Test("all presets use monospace")
    func allPresetsMonospace() {
        #expect(MoveTextStyle.standard.monospace == true)
        #expect(MoveTextStyle.compact.monospace == true)
        #expect(MoveTextStyle.highlighted.monospace == true)
    }

    @Test("MoveTextStyle conforms to Equatable")
    func equatableConformance() {
        let a = MoveTextStyle(fontSize: 14, bold: false, color: "#333", monospace: true)
        let b = MoveTextStyle(fontSize: 14, bold: false, color: "#333", monospace: true)
        #expect(a == b)
    }

    @Test("three presets are all different")
    func presetsAreDifferent() {
        #expect(MoveTextStyle.standard != MoveTextStyle.compact)
        #expect(MoveTextStyle.standard != MoveTextStyle.highlighted)
        #expect(MoveTextStyle.compact != MoveTextStyle.highlighted)
    }
}
