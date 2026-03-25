import Testing
@testable import Hnefatafl

@Suite("Control Map Tests")
struct ControlMapTests {

    @Test("empty board has all empty squares")
    func emptyBoardAllEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let map = ControlMapBuilder.build(position: position)
        #expect(map.attackerSquares == 0)
        #expect(map.defenderSquares == 0)
        #expect(map.contestedSquares == 0)
    }

    @Test("single attacker controls adjacent squares")
    func singleAttackerControlsAdjacent() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let map = ControlMapBuilder.build(position: position)
        #expect(map.control(row: 5, col: 6) == .attacker)
        #expect(map.control(row: 4, col: 5) == .attacker)
        #expect(map.attackerSquares == 4)
    }

    @Test("adjacent attacker and defender create contested square")
    func contestedSquare() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .defender
        let position = Position(cells: cells)
        let map = ControlMapBuilder.build(position: position)
        #expect(map.control(row: 5, col: 5) == .contested)
    }

    @Test("king contributes to defender control")
    func kingContributesToDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let map = ControlMapBuilder.build(position: position)
        #expect(map.control(row: 5, col: 6) == .defender)
        #expect(map.defenderSquares == 4)
    }

    @Test("starting position has contested squares")
    func startingPositionContested() {
        let position = Position.copenhagenStart()
        let map = ControlMapBuilder.build(position: position)
        #expect(map.contestedSquares > 0)
    }

    @Test("total squares add up correctly")
    func totalSquaresCorrect() {
        let position = Position.copenhagenStart()
        let map = ControlMapBuilder.build(position: position)
        let total = map.attackerSquares + map.defenderSquares + map.contestedSquares
        let emptyCount = map.squares.filter { $0 == .empty }.count
        #expect(total + emptyCount == 121)
    }
}
