import Testing
@testable import Hnefatafl

@Suite("StrategicValueMap Tests")
struct StrategicValueMapTests {
    @Test("Corner squares have high value")
    func cornerValue() {
        let topLeft = StrategicValueMap.standard.value(row: 0, col: 0)
        let topRight = StrategicValueMap.standard.value(row: 0, col: Position.boardSize - 1)
        let bottomLeft = StrategicValueMap.standard.value(row: Position.boardSize - 1, col: 0)
        let bottomRight = StrategicValueMap.standard.value(row: Position.boardSize - 1, col: Position.boardSize - 1)

        #expect(topLeft > 0)
        #expect(topRight > 0)
        #expect(bottomLeft > 0)
        #expect(bottomRight > 0)
    }

    @Test("Throne has high value")
    func throneValue() {
        let mid = Position.boardSize / 2
        let throneValue = StrategicValueMap.standard.value(row: mid, col: mid)
        #expect(throneValue > 0)
    }

    @Test("Edge squares have medium value")
    func edgeValue() {
        let topEdge = StrategicValueMap.standard.value(row: 0, col: 5)
        let leftEdge = StrategicValueMap.standard.value(row: 5, col: 0)
        #expect(topEdge > 0)
        #expect(leftEdge > 0)
    }

    @Test("Center squares have lower value than corners")
    func centerValue() {
        let cornerValue = StrategicValueMap.standard.value(row: 0, col: 0)
        let centerValue = StrategicValueMap.standard.value(row: 3, col: 3)
        #expect(cornerValue > centerValue)
    }

    @Test("All values are non-negative")
    func allValuesNonNegative() {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let val = StrategicValueMap.standard.value(row: row, col: col)
                #expect(val >= 0)
            }
        }
    }

    @Test("Map is symmetric")
    func symmetry() {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let val1 = StrategicValueMap.standard.value(row: row, col: col)
                let val2 = StrategicValueMap.standard.value(row: row, col: Position.boardSize - 1 - col)
                let val3 = StrategicValueMap.standard.value(row: Position.boardSize - 1 - row, col: col)
                #expect(val1 == val2)
                #expect(val1 == val3)
            }
        }
    }
}
