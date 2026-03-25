import Testing
@testable import Hnefatafl

@Suite("SquareHighlightData Tests")
struct SquareHighlightDataTests {
    @Test("Selected reason has correct raw value")
    func selectedRawValue() {
        #expect(HighlightReason.selected.rawValue == "selected")
    }

    @Test("LegalMove reason has correct raw value")
    func legalMoveRawValue() {
        #expect(HighlightReason.legalMove.rawValue == "legalMove")
    }

    @Test("LastMove reason has correct raw value")
    func lastMoveRawValue() {
        #expect(HighlightReason.lastMove.rawValue == "lastMove")
    }

    @Test("Threat reason has correct raw value")
    func threatRawValue() {
        #expect(HighlightReason.threat.rawValue == "threat")
    }

    @Test("SquareHighlightData stores coordinates correctly")
    func coordinatesStored() {
        let data = SquareHighlightData(row: 3, col: 7, reason: .selected)
        #expect(data.row == 3)
        #expect(data.col == 7)
    }

    @Test("Equatable conformance for SquareHighlightData")
    func equatable() {
        let a = SquareHighlightData(row: 5, col: 5, reason: .threat)
        let b = SquareHighlightData(row: 5, col: 5, reason: .threat)
        #expect(a == b)
    }

    @Test("Different reasons are not equal")
    func differentReasons() {
        let a = SquareHighlightData(row: 0, col: 0, reason: .selected)
        let b = SquareHighlightData(row: 0, col: 0, reason: .legalMove)
        #expect(a != b)
    }
}
