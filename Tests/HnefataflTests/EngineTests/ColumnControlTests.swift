import Testing
@testable import Hnefatafl

@Suite("Column Control Tests")
struct ColumnControlTests {

    @Test("start position returns nonzero attacker columns")
    func startPositionAttacker() {
        let pos = Position.copenhagenStart()
        let cols = ColumnControl.controlledColumns(position: pos, player: .attacker)
        #expect(cols > 0)
    }

    @Test("start position returns nonzero defender columns")
    func startPositionDefender() {
        let pos = Position.copenhagenStart()
        let cols = ColumnControl.controlledColumns(position: pos, player: .defender)
        #expect(cols > 0)
    }

    @Test("empty board returns zero controlled columns")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let cols = ColumnControl.controlledColumns(position: pos, player: .attacker)
        #expect(cols == 0)
    }

    @Test("single attacker in column controls that column")
    func singleAttackerColumn() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .attacker
        let pos = Position(cells: cells)
        let cols = ColumnControl.controlledColumns(position: pos, player: .attacker)
        #expect(cols == 1)
    }

    @Test("columnScore positive when attacker controls more")
    func scorePositiveForAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .attacker
        cells[1 * 11 + 1] = .attacker
        cells[2 * 11 + 2] = .attacker
        cells[5 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(ColumnControl.columnScore(position: pos) > 0)
    }

    @Test("columnScore zero on empty board")
    func scoreZeroEmpty() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(ColumnControl.columnScore(position: pos) == 0)
    }

    @Test("tied column not counted for either player")
    func tiedColumn() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 4] = .attacker
        cells[1 * 11 + 4] = .defender
        let pos = Position(cells: cells)
        let attackerCols = ColumnControl.controlledColumns(position: pos, player: .attacker)
        let defenderCols = ColumnControl.controlledColumns(position: pos, player: .defender)
        #expect(attackerCols == 0)
        #expect(defenderCols == 0)
    }
}
