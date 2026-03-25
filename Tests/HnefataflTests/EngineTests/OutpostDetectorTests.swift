import Testing
@testable import Hnefatafl

@Suite("Outpost Detector Tests")
struct OutpostDetectorTests {

    @Test("empty board returns no outposts")
    func emptyBoardNoOutposts() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let result = OutpostDetector.outposts(position: position, player: .attacker)
        #expect(result.isEmpty)
    }

    @Test("piece with two friendly neighbors and no enemies is outpost")
    func pieceWithTwoFriendlyNeighbors() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let result = OutpostDetector.outposts(position: position, player: .attacker)
        let centerIsOutpost = result.contains { $0.row == 5 && $0.col == 5 }
        #expect(centerIsOutpost)
    }

    @Test("piece with enemy neighbor is not outpost")
    func pieceWithEnemyNeighborNotOutpost() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let result = OutpostDetector.outposts(position: position, player: .attacker)
        let centerIsOutpost = result.contains { $0.row == 5 && $0.col == 5 }
        #expect(!centerIsOutpost)
    }

    @Test("defender outpost with king as friendly neighbor")
    func defenderOutpostWithKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 6] = .king
        cells[4 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let result = OutpostDetector.outposts(position: position, player: .defender)
        let hasOutpost = result.contains { $0.row == 5 && $0.col == 5 }
        #expect(hasOutpost)
    }

    @Test("piece with only one friendly neighbor is not outpost")
    func oneFriendlyNeighborNotOutpost() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        let result = OutpostDetector.outposts(position: position, player: .attacker)
        let centerIsOutpost = result.contains { $0.row == 5 && $0.col == 5 }
        #expect(!centerIsOutpost)
    }
}
