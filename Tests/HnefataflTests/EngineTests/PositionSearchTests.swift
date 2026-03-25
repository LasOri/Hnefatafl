import Testing
@testable import Hnefatafl

@Suite("PositionSearch Tests")
struct PositionSearchTests {

    @Test("search with no criteria returns true for any position")
    func noCriteria() {
        let criteria = SearchCriteria()
        let pos = Position.copenhagenStart()
        #expect(PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search by minimum attacker count")
    func minAttackers() {
        let criteria = SearchCriteria(minAttackers: 24)
        let pos = Position.copenhagenStart()
        #expect(PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search fails when attacker count too low")
    func minAttackersFail() {
        let criteria = SearchCriteria(minAttackers: 24)
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 0)
            .build()
        #expect(!PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search by piece at specific square")
    func pieceAtSquare() {
        let criteria = SearchCriteria(requiredPieces: [(row: 5, col: 5, piece: .king)])
        let pos = Position.copenhagenStart()
        #expect(PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search fails when piece not at square")
    func pieceAtSquareFail() {
        let criteria = SearchCriteria(requiredPieces: [(row: 0, col: 0, piece: .king)])
        let pos = Position.copenhagenStart()
        #expect(!PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search by empty square requirement")
    func emptySquare() {
        let criteria = SearchCriteria(requiredEmpty: [(row: 0, col: 0)])
        let pos = Position.copenhagenStart()
        #expect(PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("search by max defenders")
    func maxDefenders() {
        let criteria = SearchCriteria(maxDefenders: 5)
        let pos = Position.copenhagenStart()
        #expect(!PositionSearch.matches(position: pos, criteria: criteria))
    }

    @Test("SearchCriteria is Equatable")
    func criteriaEquatable() {
        let a = SearchCriteria(minAttackers: 5)
        let b = SearchCriteria(minAttackers: 5)
        #expect(a == b)
    }

    @Test("combined criteria all must match")
    func combinedCriteria() {
        let criteria = SearchCriteria(
            minAttackers: 1,
            requiredPieces: [(row: 5, col: 5, piece: .king)]
        )
        let pos = Position.copenhagenStart()
        #expect(PositionSearch.matches(position: pos, criteria: criteria))
    }
}
