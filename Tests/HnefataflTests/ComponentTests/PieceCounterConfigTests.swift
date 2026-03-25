import Testing
@testable import Hnefatafl

@Suite("Piece Counter Config Tests")
struct PieceCounterConfigTests {

    @Test("full preset shows all pieces")
    func fullShowsAll() {
        let config = PieceCounterConfig.full
        #expect(config.showAttackers == true)
        #expect(config.showDefenders == true)
        #expect(config.showKing == true)
    }

    @Test("full preset is not compact")
    func fullNotCompact() {
        #expect(PieceCounterConfig.full.compact == false)
    }

    @Test("minimal preset hides king")
    func minimalHidesKing() {
        #expect(PieceCounterConfig.minimal.showKing == false)
    }

    @Test("minimal preset is compact")
    func minimalIsCompact() {
        #expect(PieceCounterConfig.minimal.compact == true)
    }

    @Test("minimal shows attackers and defenders")
    func minimalShowsAttDef() {
        #expect(PieceCounterConfig.minimal.showAttackers == true)
        #expect(PieceCounterConfig.minimal.showDefenders == true)
    }

    @Test("configs are equatable")
    func equatable() {
        let a = PieceCounterConfig.full
        let b = PieceCounterConfig(showAttackers: true, showDefenders: true, showKing: true, compact: false)
        #expect(a == b)
    }

    @Test("full and minimal differ")
    func fullMinimalDiffer() {
        #expect(PieceCounterConfig.full != PieceCounterConfig.minimal)
    }
}
