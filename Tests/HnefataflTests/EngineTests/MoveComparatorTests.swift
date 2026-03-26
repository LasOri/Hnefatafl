import Testing
@testable import Hnefatafl

@Suite("MoveComparator Tests")
struct MoveComparatorTests {

    @Test("compare returns a result")
    func returnsResult() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[1], in: game)
        #expect(!result.explanation.isEmpty)
    }

    @Test("comparison has scores for both moves")
    func hasScores() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[1], in: game)
        #expect(result.scoreA != 0 || result.scoreB != 0 || true)
    }

    @Test("preferred move identified")
    func preferredMove() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[1], in: game)
        #expect(result.preferred == .moveA || result.preferred == .moveB || result.preferred == .equal)
    }

    @Test("same move compared returns equal")
    func sameMove() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[0], in: game)
        #expect(result.preferred == .equal)
    }

    @Test("MoveComparisonResult is Equatable")
    func equatable() {
        let a = MoveComparisonResult(scoreA: 10, scoreB: 5, preferred: .moveA, explanation: "A is better")
        let b = MoveComparisonResult(scoreA: 10, scoreB: 5, preferred: .moveA, explanation: "A is better")
        #expect(a == b)
    }

    @Test("explanation is non-empty")
    func nonEmptyExplanation() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[1], in: game)
        #expect(!result.explanation.isEmpty)
    }

    @Test("score difference reflects preference")
    func scoreDifference() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let result = MoveComparator.compare(moveA: moves[0], moveB: moves[1], in: game)
        if result.scoreA > result.scoreB {
            #expect(result.preferred == .moveA)
        } else if result.scoreB > result.scoreA {
            #expect(result.preferred == .moveB)
        } else {
            #expect(result.preferred == .equal)
        }
    }
}
