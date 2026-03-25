import Testing
@testable import Hnefatafl

@Suite("Board Region Label Tests")
struct BoardRegionLabelTests {

    @Test("corners are labeled corner")
    func cornersLabeled() {
        #expect(BoardRegionLabel.label(row: 0, col: 0) == .corner)
        #expect(BoardRegionLabel.label(row: 0, col: 10) == .corner)
        #expect(BoardRegionLabel.label(row: 10, col: 0) == .corner)
        #expect(BoardRegionLabel.label(row: 10, col: 10) == .corner)
    }

    @Test("north edge squares labeled northEdge")
    func northEdge() {
        #expect(BoardRegionLabel.label(row: 0, col: 5) == .northEdge)
    }

    @Test("south edge squares labeled southEdge")
    func southEdge() {
        #expect(BoardRegionLabel.label(row: 10, col: 5) == .southEdge)
    }

    @Test("west edge squares labeled westEdge")
    func westEdge() {
        #expect(BoardRegionLabel.label(row: 5, col: 0) == .westEdge)
    }

    @Test("east edge squares labeled eastEdge")
    func eastEdge() {
        #expect(BoardRegionLabel.label(row: 5, col: 10) == .eastEdge)
    }

    @Test("center square labeled center")
    func centerLabel() {
        #expect(BoardRegionLabel.label(row: 5, col: 5) == .center)
    }

    @Test("BoardRegionLabel is equatable")
    func equatable() {
        let a = BoardRegionLabel(region: .center, pieceCount: 3)
        let b = BoardRegionLabel(region: .center, pieceCount: 3)
        let c = BoardRegionLabel(region: .corner, pieceCount: 3)
        #expect(a == b)
        #expect(a != c)
    }
}
