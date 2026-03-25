import Testing
@testable import Hnefatafl

@Suite("Row Control Tests")
struct RowControlTests {

    @Test("start position returns nonzero attacker rows")
    func startPositionAttacker() {
        let pos = Position.copenhagenStart()
        let rows = RowControl.controlledRows(position: pos, player: .attacker)
        #expect(rows > 0)
    }

    @Test("start position returns nonzero defender rows")
    func startPositionDefender() {
        let pos = Position.copenhagenStart()
        let rows = RowControl.controlledRows(position: pos, player: .defender)
        #expect(rows > 0)
    }

    @Test("empty board returns zero controlled rows")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let rows = RowControl.controlledRows(position: pos, player: .attacker)
        #expect(rows == 0)
    }

    @Test("single attacker in row controls that row")
    func singleAttackerRow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 0] = .attacker
        let pos = Position(cells: cells)
        let rows = RowControl.controlledRows(position: pos, player: .attacker)
        #expect(rows == 1)
    }

    @Test("rowScore positive when attacker controls more")
    func scorePositiveForAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .attacker
        cells[1 * 11 + 0] = .attacker
        cells[2 * 11 + 0] = .attacker
        cells[5 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(RowControl.rowScore(position: pos) > 0)
    }

    @Test("rowScore zero on empty board")
    func scoreZeroEmpty() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(RowControl.rowScore(position: pos) == 0)
    }

    @Test("tied row not counted for either player")
    func tiedRow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[4 * 11 + 0] = .attacker
        cells[4 * 11 + 1] = .defender
        let pos = Position(cells: cells)
        let attackerRows = RowControl.controlledRows(position: pos, player: .attacker)
        let defenderRows = RowControl.controlledRows(position: pos, player: .defender)
        #expect(attackerRows == 0)
        #expect(defenderRows == 0)
    }
}
