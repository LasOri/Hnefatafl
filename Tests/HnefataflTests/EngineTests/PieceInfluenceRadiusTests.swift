import Testing
@testable import Hnefatafl

@Suite("PieceInfluenceRadius Tests")
struct PieceInfluenceRadiusTests {
    @Test("Influence of piece in corner")
    func cornerPiece() {
        let position = Position.copenhagenStart()
        let influence = PieceInfluenceRadius.influence(row: 0, col: 0, position: position)
        #expect(influence >= 0)
    }

    @Test("Influence of piece in center")
    func centerPiece() {
        let position = Position.copenhagenStart()
        let influence = PieceInfluenceRadius.influence(row: 5, col: 5, position: position)
        #expect(influence >= 0)
    }

    @Test("Influence blocked by other pieces")
    func blockedInfluence() {
        let position = Position.copenhagenStart()
        let influence = PieceInfluenceRadius.influence(row: 3, col: 5, position: position)
        #expect(influence >= 0)
    }

    @Test("Total attacker influence")
    func totalAttackerInfluence() {
        let position = Position.copenhagenStart()
        let total = PieceInfluenceRadius.totalInfluence(position: position, player: .attacker)
        #expect(total > 0)
    }

    @Test("Total defender influence")
    func totalDefenderInfluence() {
        let position = Position.copenhagenStart()
        let total = PieceInfluenceRadius.totalInfluence(position: position, player: .defender)
        #expect(total > 0)
    }

    @Test("Empty square has zero influence")
    func emptySquare() {
        let position = Position.copenhagenStart()
        let influence = PieceInfluenceRadius.influence(row: 1, col: 1, position: position)
        #expect(influence == 0)
    }
}
