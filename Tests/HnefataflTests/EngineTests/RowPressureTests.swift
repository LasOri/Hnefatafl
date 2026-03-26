import Testing
@testable import Hnefatafl

@Suite("RowPressure Tests")
struct RowPressureTests {

    @Test("starting position has row pressure")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let pressure = RowPressure.evaluate(position: pos, for: .attacker)
        #expect(!pressure.isEmpty)
    }

    @Test("all 11 rows represented")
    func allRows() {
        let pos = Position.copenhagenStart()
        let pressure = RowPressure.evaluate(position: pos, for: .attacker)
        #expect(pressure.count == 11)
    }

    @Test("pressure is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let pressure = RowPressure.evaluate(position: pos, for: .attacker)
        for entry in pressure {
            #expect(entry.pressure >= 0)
        }
    }

    @Test("empty board has no pressure")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let pressure = RowPressure.evaluate(position: pos, for: .attacker)
        #expect(pressure.allSatisfy { $0.pressure == 0 })
    }

    @Test("RowPressureEntry is Equatable")
    func equatable() {
        let a = RowPressureEntry(row: 0, pressure: 3)
        let b = RowPressureEntry(row: 0, pressure: 3)
        #expect(a == b)
    }

    @Test("row index is valid")
    func validIndex() {
        let pos = Position.copenhagenStart()
        let pressure = RowPressure.evaluate(position: pos, for: .defender)
        for entry in pressure {
            #expect(entry.row >= 0 && entry.row < 11)
        }
    }
}
