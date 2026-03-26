import Testing
@testable import Hnefatafl

@Suite("PieceAlignment Tests")
struct PieceAlignmentTests {

    @Test("aligned pieces on same row detected")
    func sameRow() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 2)
            .place(.attacker, row: 3, col: 5)
            .place(.attacker, row: 3, col: 8)
            .place(.king, row: 0, col: 0)
            .build()
        let alignments = PieceAlignment.detect(position: pos, for: .attacker)
        let rowAlignments = alignments.filter { $0.axis == .row }
        #expect(!rowAlignments.isEmpty)
    }

    @Test("aligned pieces on same column detected")
    func sameCol() {
        let pos = PositionBuilder()
            .place(.attacker, row: 2, col: 5)
            .place(.attacker, row: 5, col: 5)
            .place(.attacker, row: 8, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let alignments = PieceAlignment.detect(position: pos, for: .attacker)
        let colAlignments = alignments.filter { $0.axis == .column }
        #expect(!colAlignments.isEmpty)
    }

    @Test("single piece has no alignment")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let alignments = PieceAlignment.detect(position: pos, for: .attacker)
        #expect(alignments.isEmpty)
    }

    @Test("AlignmentEntry is Equatable")
    func equatable() {
        let a = AlignmentEntry(axis: .row, index: 3, count: 2)
        let b = AlignmentEntry(axis: .row, index: 3, count: 2)
        #expect(a == b)
    }

    @Test("alignment needs at least 2 pieces")
    func minimumPieces() {
        let pos = Position.copenhagenStart()
        let alignments = PieceAlignment.detect(position: pos, for: .attacker)
        for a in alignments {
            #expect(a.count >= 2)
        }
    }

    @Test("AlignmentAxis has row and column")
    func axisValues() {
        #expect(AlignmentAxis.row != AlignmentAxis.column)
    }
}
