import Testing
@testable import Hnefatafl

@Suite("Board Pattern Tests")
struct BoardPatternTests {

    @Test("empty board has no patterns")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.isEmpty)
    }

    @Test("edge wall detected for 3+ attackers on same edge")
    func edgeWall() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        cells[0] = .attacker
        cells[1] = .attacker
        cells[2] = .attacker
        let position = Position(cells: cells)
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.contains(.edgeWall))
    }

    @Test("corner control detected when attacker near corner")
    func cornerControl() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        cells[1] = .attacker
        cells[11] = .attacker
        let position = Position(cells: cells)
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.contains(.cornerControl))
    }

    @Test("king near edge detected")
    func kingNearEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .king
        let position = Position(cells: cells)
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.contains(.kingNearEdge))
    }

    @Test("starting position has edge walls")
    func startingPosition() {
        let position = Position.copenhagenStart()
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.contains(.edgeWall))
    }

    @Test("BoardPattern has expected cases")
    func patternCases() {
        let all: [BoardPattern] = [.edgeWall, .cornerControl, .kingNearEdge, .centralFortress]
        #expect(all.count == 4)
    }

    @Test("central fortress detected when king surrounded by defenders")
    func centralFortress() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        let center = 5 * 11 + 5
        cells[center] = .king
        cells[center - 1] = .defender
        cells[center + 1] = .defender
        cells[center - 11] = .defender
        cells[center + 11] = .defender
        let position = Position(cells: cells)
        let patterns = BoardPatternDetector.detect(position: position)
        #expect(patterns.contains(.centralFortress))
    }

    @Test("pattern description is non-empty")
    func patternDescription() {
        #expect(!BoardPattern.edgeWall.label.isEmpty)
        #expect(!BoardPattern.cornerControl.label.isEmpty)
        #expect(!BoardPattern.kingNearEdge.label.isEmpty)
        #expect(!BoardPattern.centralFortress.label.isEmpty)
    }
}
