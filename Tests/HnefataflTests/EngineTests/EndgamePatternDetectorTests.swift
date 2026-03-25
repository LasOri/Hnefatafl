import Testing
@testable import Hnefatafl

@Suite("Endgame Pattern Detector Tests")
struct EndgamePatternDetectorTests {

    @Test("lone king detected")
    func loneKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(EndgamePatternDetector.detectPattern(position: pos) == "Lone King")
    }

    @Test("king plus one defender detected")
    func kingPlusDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[0] = .attacker
        cells[1] = .attacker
        let pos = Position(cells: cells)
        #expect(EndgamePatternDetector.detectPattern(position: pos) == "King + 1 Defender")
    }

    @Test("no pattern in start position")
    func startPositionNoPattern() {
        let pos = Position.copenhagenStart()
        #expect(EndgamePatternDetector.detectPattern(position: pos) == nil)
    }

    @Test("isKnownWin for defender with few attackers")
    func defenderKnownWin() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[3 * 11 + 5] = .defender
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(EndgamePatternDetector.isKnownWin(position: pos, for: .defender) == true)
    }

    @Test("isKnownWin for attacker with lone king and many attackers")
    func attackerKnownWin() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        cells[1] = .attacker
        cells[2] = .attacker
        cells[3] = .attacker
        let pos = Position(cells: cells)
        #expect(EndgamePatternDetector.isKnownWin(position: pos, for: .attacker) == true)
    }

    @Test("start position is not a known win")
    func startNotKnownWin() {
        let pos = Position.copenhagenStart()
        #expect(EndgamePatternDetector.isKnownWin(position: pos, for: .attacker) == false)
        #expect(EndgamePatternDetector.isKnownWin(position: pos, for: .defender) == false)
    }
}
