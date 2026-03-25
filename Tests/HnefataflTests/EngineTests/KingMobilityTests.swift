import Testing
@testable import Hnefatafl

@Suite("King Mobility Tests")
struct KingMobilityTests {

    @Test("start position king has zero moves (surrounded by defenders)")
    func startPositionKingZero() {
        let position = Position.copenhagenStart()
        #expect(KingMobility.moveCount(position: position) == 0)
    }

    @Test("no king returns zero moves")
    func noKingZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingMobility.moveCount(position: position) == 0)
    }

    @Test("no king is detected as trapped")
    func noKingTrapped() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingMobility.isTrapped(position: position) == true)
    }

    @Test("lone king has moves")
    func loneKingHasMoves() {
        let position = emptyBoard()
            .placing(.king, row: 3, col: 3)
            .build()
        #expect(KingMobility.moveCount(position: position) > 0)
    }

    @Test("move count is non-negative")
    func nonNegative() {
        let position = Position.copenhagenStart()
        #expect(KingMobility.moveCount(position: position) >= 0)
    }
}
