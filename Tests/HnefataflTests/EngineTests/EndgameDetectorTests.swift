import Testing
@testable import Hnefatafl

@Suite("Endgame Detector Tests")
struct EndgameDetectorTests {

    @Test("starting position is not endgame")
    func startingNotEndgame() {
        let position = Position.copenhagenStart()
        #expect(EndgameDetector.phase(position: position) == .opening)
    }

    @Test("few pieces is endgame")
    func fewPiecesEndgame() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        cells[1] = .attacker
        let position = Position(cells: cells)
        #expect(EndgameDetector.phase(position: position) == .endgame)
    }

    @Test("moderate pieces is midgame")
    func midgame() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        for i in 0..<10 { cells[i] = .attacker }
        for i in 20..<26 { cells[i] = .defender }
        let position = Position(cells: cells)
        #expect(EndgameDetector.phase(position: position) == .midgame)
    }

    @Test("GamePhase has three cases")
    func threeCases() {
        let phases: [GamePhase] = [.opening, .midgame, .endgame]
        #expect(phases.count == 3)
    }

    @Test("endgame threshold is 8 total pieces")
    func endgameThreshold() {
        #expect(EndgameDetector.endgameThreshold == 8)
    }

    @Test("midgame threshold is 20 total pieces")
    func midgameThreshold() {
        #expect(EndgameDetector.midgameThreshold == 20)
    }

    @Test("king alone is endgame")
    func kingAlone() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        let position = Position(cells: cells)
        #expect(EndgameDetector.phase(position: position) == .endgame)
    }

    @Test("piece count returns total non-nil pieces")
    func pieceCount() {
        let position = Position.copenhagenStart()
        let count = EndgameDetector.pieceCount(position: position)
        #expect(count == 37)
    }
}
