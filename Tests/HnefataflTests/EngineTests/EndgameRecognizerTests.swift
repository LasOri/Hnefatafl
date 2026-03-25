import Testing
@testable import Hnefatafl

@Suite("Endgame Recognizer Tests")
struct EndgameRecognizerTests {

    @Test("king alone pattern")
    func kingAlone() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(EndgameRecognizer.recognize(position: position) == .kingAlone)
    }

    @Test("king with one defender and few attackers")
    func kingWithDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[0] = .attacker
        let position = Position(cells: cells)
        #expect(EndgameRecognizer.recognize(position: position) == .kingWithDefender)
    }

    @Test("few attackers pattern")
    func fewAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        cells[3 * 11 + 5] = .defender
        cells[6 * 11 + 5] = .defender
        cells[0] = .attacker
        cells[1] = .attacker
        let position = Position(cells: cells)
        #expect(EndgameRecognizer.recognize(position: position) == .fewAttackers)
    }

    @Test("starting position is unknown")
    func startingPositionUnknown() {
        let position = Position.copenhagenStart()
        #expect(EndgameRecognizer.recognize(position: position) == .unknown)
    }

    @Test("endgame pattern raw values")
    func rawValues() {
        #expect(EndgamePattern.kingAlone.rawValue == "King Alone")
        #expect(EndgamePattern.kingWithDefender.rawValue == "King + Defender")
        #expect(EndgamePattern.fewAttackers.rawValue == "Few Attackers")
        #expect(EndgamePattern.unknown.rawValue == "Unknown")
    }
}
