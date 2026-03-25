import Testing
@testable import Hnefatafl

@Suite("EndgameKnowledge Tests")
struct EndgameKnowledgeTests {

    @Test("no king is theoretical win for attacker")
    func noKingAttackerWins() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        #expect(EndgameKnowledge.isTheoreticalWin(position: position, for: .attacker) == true)
    }

    @Test("lone king with no attackers is defender win")
    func loneKingDefenderWins() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(EndgameKnowledge.isTheoreticalWin(position: position, for: .defender) == true)
    }

    @Test("start position is not theoretical win for either")
    func startNotTheoreticalWin() {
        let position = Position.copenhagenStart()
        #expect(EndgameKnowledge.isTheoreticalWin(position: position, for: .attacker) == false)
        #expect(EndgameKnowledge.isTheoreticalWin(position: position, for: .defender) == false)
    }

    @Test("minimum moves for lone king is corner distance")
    func minimumMovesLoneKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let moves = EndgameKnowledge.minimumMovesToWin(position: position)
        #expect(moves != nil)
        #expect(moves! > 0)
    }

    @Test("minimum moves for start position is nil")
    func minimumMovesStartNil() {
        let position = Position.copenhagenStart()
        #expect(EndgameKnowledge.minimumMovesToWin(position: position) == nil)
    }

    @Test("king near corner with few attackers is defender win")
    func kingNearCornerDefenderWin() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 1] = .king
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(EndgameKnowledge.isTheoreticalWin(position: position, for: .defender) == true)
    }
}
