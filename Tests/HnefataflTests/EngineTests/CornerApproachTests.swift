import Testing
@testable import Hnefatafl

@Suite("Corner Approach Tests")
struct CornerApproachTests {

    @Test("no king returns nil distance")
    func noKingNilDistance() {
        let pos = emptyBoard().build()
        #expect(CornerApproach.closestCornerDistance(position: pos) == nil)
    }

    @Test("king at corner has zero distance")
    func kingAtCornerZero() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        #expect(CornerApproach.closestCornerDistance(position: pos) == 0)
    }

    @Test("king at center has distance 10")
    func kingAtCenterDistance() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(CornerApproach.closestCornerDistance(position: pos) == 10)
    }

    @Test("no king returns zero approach score")
    func noKingZeroScore() {
        let pos = emptyBoard().build()
        #expect(CornerApproach.approachScore(position: pos) == 0)
    }

    @Test("king at corner has maximum approach score")
    func kingAtCornerMaxScore() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let score = CornerApproach.approachScore(position: pos)
        #expect(score > 0)
    }

    @Test("king closer to corner has higher score")
    func closerKingHigherScore() {
        let nearCorner = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .build()
        let farAway = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let nearScore = CornerApproach.approachScore(position: nearCorner)
        let farScore = CornerApproach.approachScore(position: farAway)
        #expect(nearScore > farScore)
    }

    @Test("king near edge has smaller distance")
    func kingNearEdge() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .build()
        #expect(CornerApproach.closestCornerDistance(position: pos) == 1)
    }
}
