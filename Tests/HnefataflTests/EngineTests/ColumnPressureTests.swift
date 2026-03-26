import Testing
@testable import Hnefatafl

@Suite("ColumnPressure Tests")
struct ColumnPressureTests {

    @Test("starting position has column pressure")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let pressure = ColumnPressure.evaluate(position: pos, for: .attacker)
        #expect(!pressure.isEmpty)
    }

    @Test("pressure entry has column index")
    func columnIndex() {
        let pos = Position.copenhagenStart()
        let pressure = ColumnPressure.evaluate(position: pos, for: .attacker)
        for entry in pressure {
            #expect(entry.column >= 0 && entry.column < 11)
        }
    }

    @Test("pressure score is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let pressure = ColumnPressure.evaluate(position: pos, for: .attacker)
        for entry in pressure {
            #expect(entry.pressure >= 0)
        }
    }

    @Test("empty board has no pressure")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let pressure = ColumnPressure.evaluate(position: pos, for: .attacker)
        #expect(pressure.allSatisfy { $0.pressure == 0 })
    }

    @Test("ColumnPressureEntry is Equatable")
    func equatable() {
        let a = ColumnPressureEntry(column: 0, pressure: 5)
        let b = ColumnPressureEntry(column: 0, pressure: 5)
        #expect(a == b)
    }

    @Test("all 11 columns represented")
    func allColumns() {
        let pos = Position.copenhagenStart()
        let pressure = ColumnPressure.evaluate(position: pos, for: .attacker)
        #expect(pressure.count == 11)
    }
}
