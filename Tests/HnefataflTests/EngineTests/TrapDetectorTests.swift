import Testing
@testable import Hnefatafl

@Suite("Trap Detector Tests")
struct TrapDetectorTests {

    @Test("empty board has no traps")
    func emptyBoardNoTraps() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let traps = TrapDetector.detectTraps(position: position, player: .attacker)
        #expect(traps.isEmpty)
    }

    @Test("trap count matches detect traps count")
    func trapCountMatchesDetect() {
        let position = Position.copenhagenStart()
        let traps = TrapDetector.detectTraps(position: position, player: .attacker)
        let count = TrapDetector.trapCount(position: position, player: .attacker)
        #expect(traps.count == count)
    }

    @Test("piece surrounded on three sides with enemy coverage is trapped")
    func pieceSurroundedOnThreeSides() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .defender
        cells[0 * 11 + 0] = .attacker
        cells[0 * 11 + 2] = .attacker
        cells[1 * 11 + 1] = .attacker
        let position = Position(cells: cells)
        let traps = TrapDetector.detectTraps(position: position, player: .defender)
        let trapped = traps.contains { $0.row == 0 && $0.col == 1 }
        #expect(trapped)
    }

    @Test("piece with open escape is not trapped")
    func pieceWithOpenEscapeNotTrapped() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        let traps = TrapDetector.detectTraps(position: position, player: .defender)
        let trapped = traps.contains { $0.row == 5 && $0.col == 5 }
        #expect(!trapped)
    }

    @Test("king is never reported as trapped")
    func kingNeverTrapped() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .attacker
        cells[11] = .attacker
        let position = Position(cells: cells)
        let traps = TrapDetector.detectTraps(position: position, player: .defender)
        let kingTrapped = traps.contains { $0.row == 0 && $0.col == 0 }
        #expect(!kingTrapped)
    }

    @Test("trap count is zero for empty board")
    func trapCountZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(TrapDetector.trapCount(position: position, player: .attacker) == 0)
        #expect(TrapDetector.trapCount(position: position, player: .defender) == 0)
    }
}
