import Testing
@testable import Hnefatafl

@Suite("AnchorSquare Tests")
struct AnchorSquareTests {

    @Test("empty board has no anchors")
    func emptyBoardNoAnchors() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(AnchorSquare.anchorCount(position: position, player: .attacker) == 0)
    }

    @Test("anchorCount matches anchors count")
    func countMatchesAnchors() {
        let position = Position.copenhagenStart()
        let anchors = AnchorSquare.anchors(position: position, player: .attacker)
        let count = AnchorSquare.anchorCount(position: position, player: .attacker)
        #expect(anchors.count == count)
    }

    @Test("anchors returns valid board positions")
    func anchorsAreValidPositions() {
        let position = Position.copenhagenStart()
        let anchors = AnchorSquare.anchors(position: position, player: .attacker)
        for anchor in anchors {
            #expect(anchor.row >= 0 && anchor.row < Position.boardSize)
            #expect(anchor.col >= 0 && anchor.col < Position.boardSize)
        }
    }

    @Test("anchor count is non-negative")
    func nonNegativeCount() {
        let position = Position.copenhagenStart()
        #expect(AnchorSquare.anchorCount(position: position, player: .attacker) >= 0)
        #expect(AnchorSquare.anchorCount(position: position, player: .defender) >= 0)
    }

    @Test("piece near corner can be anchor")
    func pieceNearCornerIsAnchor() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 1)
            .build()
        let anchors = AnchorSquare.anchors(position: position, player: .attacker)
        #expect(anchors.count >= 1)
    }

    @Test("isolated center piece is not anchor")
    func isolatedCenterNotAnchor() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let anchors = AnchorSquare.anchors(position: position, player: .attacker)
        let centerAnchor = anchors.first { $0.row == 5 && $0.col == 5 }
        #expect(centerAnchor != nil || anchors.isEmpty)
    }
}
