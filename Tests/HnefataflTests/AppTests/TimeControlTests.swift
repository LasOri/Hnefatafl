import Testing
@testable import Hnefatafl

@Suite("Time Control Tests")
struct TimeControlTests {

    @Test("TimeControl stores initial time")
    func storesInitialTime() {
        let tc = TimeControl(initialSeconds: 600, increment: .none)
        #expect(tc.initialSeconds == 600)
    }

    @Test("blitz preset is 5 minutes")
    func blitz() {
        let tc = TimeControl.blitz
        #expect(tc.initialSeconds == 300)
    }

    @Test("rapid preset is 15 minutes")
    func rapid() {
        let tc = TimeControl.rapid
        #expect(tc.initialSeconds == 900)
    }

    @Test("untimed preset has zero initial")
    func untimed() {
        let tc = TimeControl.untimed
        #expect(tc.initialSeconds == 0)
    }

    @Test("TimeControl with increment")
    func withIncrement() {
        let tc = TimeControl(initialSeconds: 300, increment: .fischer)
        #expect(tc.increment == .fischer)
    }

    @Test("label describes time control")
    func label() {
        let tc = TimeControl.blitz
        #expect(!tc.label.isEmpty)
    }

    @Test("isUntimed for zero seconds")
    func isUntimed() {
        #expect(TimeControl.untimed.isUntimed)
        #expect(!TimeControl.blitz.isUntimed)
    }

    @Test("TimeControl is Equatable")
    func equatable() {
        let a = TimeControl.blitz
        let b = TimeControl.blitz
        #expect(a == b)
    }
}
