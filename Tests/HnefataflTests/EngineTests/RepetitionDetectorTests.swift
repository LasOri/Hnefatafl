import Testing
@testable import Hnefatafl

@Suite("RepetitionDetector Tests")
struct RepetitionDetectorTests {

    @Test("empty detector has zero count")
    func emptyDetectorZeroCount() {
        let detector = RepetitionDetector()
        let position = Position.copenhagenStart()
        #expect(detector.count(for: position) == 0)
    }

    @Test("record increases count")
    func recordIncreasesCount() {
        var detector = RepetitionDetector()
        let position = Position.copenhagenStart()
        detector.record(position: position)
        #expect(detector.count(for: position) == 1)
    }

    @Test("same position counted multiple times")
    func samePositionCounted() {
        var detector = RepetitionDetector()
        let position = Position.copenhagenStart()
        detector.record(position: position)
        detector.record(position: position)
        #expect(detector.count(for: position) == 2)
    }

    @Test("threefold repetition detected")
    func threefoldDetected() {
        var detector = RepetitionDetector()
        let position = Position.copenhagenStart()
        detector.record(position: position)
        detector.record(position: position)
        detector.record(position: position)
        #expect(detector.isThreefoldRepetition(position: position))
    }

    @Test("no repetition for different positions")
    func noRepetitionDifferentPositions() {
        var detector = RepetitionDetector()
        let position1 = Position.copenhagenStart()
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position2 = Position(cells: cells)
        detector.record(position: position1)
        detector.record(position: position2)
        #expect(detector.count(for: position1) == 1)
        #expect(detector.count(for: position2) == 1)
        #expect(!detector.isThreefoldRepetition(position: position1))
    }

    @Test("reset clears all positions")
    func resetClearsAll() {
        var detector = RepetitionDetector()
        let position = Position.copenhagenStart()
        detector.record(position: position)
        detector.record(position: position)
        #expect(detector.totalPositions == 2)
        detector.reset()
        #expect(detector.totalPositions == 0)
        #expect(detector.count(for: position) == 0)
    }
}
