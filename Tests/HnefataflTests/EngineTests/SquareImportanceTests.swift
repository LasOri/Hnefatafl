import Testing
@testable import Hnefatafl

@Suite("SquareImportance Tests")
struct SquareImportanceTests {

    @Test("corners are important")
    func corners() {
        let score = SquareImportance.score(row: 0, col: 0)
        #expect(score > 0)
    }

    @Test("throne is important")
    func throne() {
        let score = SquareImportance.score(row: 5, col: 5)
        #expect(score > 0)
    }

    @Test("all squares have non-negative importance")
    func nonNegative() {
        for row in 0..<11 {
            for col in 0..<11 {
                #expect(SquareImportance.score(row: row, col: col) >= 0)
            }
        }
    }

    @Test("corners more important than edge midpoints")
    func cornersVsEdge() {
        let cornerScore = SquareImportance.score(row: 0, col: 0)
        let edgeScore = SquareImportance.score(row: 0, col: 5)
        #expect(cornerScore >= edgeScore)
    }

    @Test("ranking returns sorted squares")
    func ranking() {
        let ranked = SquareImportance.ranking()
        #expect(ranked.count == 121)
        for i in 0..<(ranked.count - 1) {
            #expect(ranked[i].importance >= ranked[i + 1].importance)
        }
    }

    @Test("ImportanceEntry is Equatable")
    func equatable() {
        let a = ImportanceEntry(row: 0, col: 0, importance: 10)
        let b = ImportanceEntry(row: 0, col: 0, importance: 10)
        #expect(a == b)
    }
}
