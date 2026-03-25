import Testing
@testable import Hnefatafl

@Suite("KingDistanceToCorner Tests")
struct KingDistanceToCornerTests {

    @Test("king at center is 10 from closest corner")
    func kingAtCenter() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(KingDistanceToCorner.minDistance(position: position) == 10)
    }

    @Test("king at corner is zero distance")
    func kingAtCorner() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        #expect(KingDistanceToCorner.minDistance(position: position) == 0)
    }

    @Test("no king returns Int.max")
    func noKing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingDistanceToCorner.minDistance(position: position) == Int.max)
    }

    @Test("closest corner for king near top-right")
    func closestCornerTopRight() {
        let position = emptyBoard()
            .placing(.king, row: 1, col: 9)
            .build()
        let corner = KingDistanceToCorner.closestCorner(position: position)
        #expect(corner?.row == 0)
        #expect(corner?.col == 10)
    }

    @Test("closest corner returns nil with no king")
    func closestCornerNoKing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingDistanceToCorner.closestCorner(position: position) == nil)
    }
}
