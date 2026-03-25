import Testing
@testable import Hnefatafl

@Suite("Game Footer Tests")
struct GameFooterTests {

    @Test("minimal preset hides move list")
    func minimalHidesMoveList() {
        #expect(GameFooter.minimal.showMoveList == false)
    }

    @Test("minimal preset hides timer")
    func minimalHidesTimer() {
        #expect(GameFooter.minimal.showTimer == false)
    }

    @Test("full preset shows move list")
    func fullShowsMoveList() {
        #expect(GameFooter.full.showMoveList == true)
    }

    @Test("full preset shows timer")
    func fullShowsTimer() {
        #expect(GameFooter.full.showTimer == true)
    }

    @Test("full preset has greater height than minimal")
    func fullTallerThanMinimal() {
        #expect(GameFooter.full.height > GameFooter.minimal.height)
    }

    @Test("presets are equatable")
    func equatable() {
        let a = GameFooter.minimal
        let b = GameFooter.minimal
        #expect(a == b)
    }

    @Test("minimal differs from full")
    func minimalDiffersFull() {
        #expect(GameFooter.minimal != GameFooter.full)
    }
}
