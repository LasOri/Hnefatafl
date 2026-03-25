import Testing
@testable import Hnefatafl

@Suite("Game Timeline Tests")
struct GameTimelineTests {

    @Test("empty timeline has no entries")
    func emptyTimeline() {
        let timeline = GameTimeline()
        #expect(timeline.count == 0)
        #expect(timeline.lastMove == nil)
    }

    @Test("add move creates entry")
    func addMoveCreatesEntry() {
        var timeline = GameTimeline()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        timeline.addMove(index: 0, player: .attacker, move: move)
        #expect(timeline.count == 1)
    }

    @Test("notation format is correct")
    func notationFormat() {
        var timeline = GameTimeline()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        timeline.addMove(index: 0, player: .attacker, move: move)
        let entry = timeline.entries[0]
        #expect(entry.notation.contains("-"))
        #expect(!entry.notation.isEmpty)
    }

    @Test("player is tracked")
    func playerTracked() {
        var timeline = GameTimeline()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        timeline.addMove(index: 0, player: .defender, move: move)
        #expect(timeline.entries[0].player == .defender)
    }

    @Test("count increments with each move")
    func countIncrements() {
        var timeline = GameTimeline()
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let move2 = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 8)
        timeline.addMove(index: 0, player: .attacker, move: move1)
        timeline.addMove(index: 1, player: .defender, move: move2)
        #expect(timeline.count == 2)
        #expect(timeline.lastMove?.moveIndex == 1)
    }
}
