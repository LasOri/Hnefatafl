import Testing
@testable import Hnefatafl

@Suite("Repetition Detection Tests")
struct RepetitionDetectionTests {

    @Test("new game has no repetitions")
    func noRepetitions() {
        let game = Game()
        let count = RepetitionChecker.count(position: game.position, in: game)
        #expect(count == 1)
    }

    @Test("RepetitionChecker tracks position occurrences")
    func tracksOccurrences() {
        let game = Game()
        let history = [game.position, game.position, game.position]
        let count = RepetitionChecker.countIn(position: game.position, history: history)
        #expect(count == 3)
    }

    @Test("different positions return count 0")
    func differentPositions() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let game = Game()
        let count = RepetitionChecker.countIn(position: pos, history: game.positionHistory)
        #expect(count == 0)
    }

    @Test("threefold returns true at 3 occurrences")
    func threefold() {
        let pos = Position.copenhagenStart()
        let history = [pos, pos, pos]
        #expect(RepetitionChecker.isThreefold(position: pos, history: history))
    }

    @Test("twofold returns false for threefold check")
    func twofold() {
        let pos = Position.copenhagenStart()
        let history = [pos, pos]
        #expect(!RepetitionChecker.isThreefold(position: pos, history: history))
    }

    @Test("threshold is configurable")
    func configurable() {
        let pos = Position.copenhagenStart()
        let history = [pos, pos, pos, pos, pos]
        #expect(RepetitionChecker.isRepeated(position: pos, history: history, threshold: 5))
    }

    @Test("count in game uses positionHistory")
    func countInGame() {
        let game = Game()
        let count = RepetitionChecker.count(position: game.position, in: game)
        #expect(count >= 1)
    }

    @Test("RepetitionChecker threshold constant is 3")
    func defaultThreshold() {
        #expect(RepetitionChecker.threefoldThreshold == 3)
    }
}
