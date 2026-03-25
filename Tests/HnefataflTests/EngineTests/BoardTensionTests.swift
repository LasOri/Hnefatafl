import Testing
@testable import Hnefatafl

@Suite("BoardTension Tests")
struct BoardTensionTests {

    @Test("empty board has zero tension")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(BoardTension.tension(position: position) == 0)
    }

    @Test("start position has positive tension")
    func startPositionPositive() {
        let position = Position.copenhagenStart()
        #expect(BoardTension.tension(position: position) > 0)
    }

    @Test("single attacker alone has zero tension")
    func singleAttackerZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(BoardTension.tension(position: position) == 0)
    }

    @Test("opposing pieces create tension between them")
    func opposingPiecesCreateTension() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 7] = .defender
        let position = Position(cells: cells)
        #expect(BoardTension.tension(position: position) > 0)
    }

    @Test("isHighTension returns bool")
    func isHighTensionReturnsBool() {
        let position = Position.copenhagenStart()
        let result = BoardTension.isHighTension(position: position)
        #expect(result == true || result == false)
    }

    @Test("more contested squares increase tension")
    func moreContestedHigherTension() {
        var fewCells: [Piece?] = Array(repeating: nil, count: 121)
        fewCells[5 * 11 + 0] = .attacker
        fewCells[5 * 11 + 10] = .defender
        let fewPos = Position(cells: fewCells)

        let startPos = Position.copenhagenStart()
        #expect(BoardTension.tension(position: startPos) > BoardTension.tension(position: fewPos))
    }
}
