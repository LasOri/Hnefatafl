import Testing
@testable import Hnefatafl

@Suite("MoveExplanation Tests")
struct MoveExplanationTests {

    @Test("explain returns non-empty text")
    func nonEmpty() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let explanation = MoveExplanation.explain(move: move, in: game)
        #expect(!explanation.text.isEmpty)
    }

    @Test("explanation mentions piece type")
    func mentionsPiece() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let explanation = MoveExplanation.explain(move: move, in: game)
        let lower = explanation.text.lowercased()
        #expect(lower.contains("attacker") || lower.contains("piece"))
    }

    @Test("explanation has factors list")
    func hasFactors() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let explanation = MoveExplanation.explain(move: move, in: game)
        #expect(!explanation.factors.isEmpty)
    }

    @Test("explanation includes score")
    func includesScore() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let explanation = MoveExplanation.explain(move: move, in: game)
        #expect(explanation.score != 0 || explanation.factors.count > 0)
    }

    @Test("explanation for defender move mentions defender")
    func defenderMove() {
        let game = Game()
        let attackerMove = game.position.allLegalMoves(for: .attacker).first!
        let afterAttack = game.makeMove(attackerMove)
        let defenderMove = afterAttack.position.allLegalMoves(for: .defender).first!
        let explanation = MoveExplanation.explain(move: defenderMove, in: afterAttack)
        let lower = explanation.text.lowercased()
        #expect(lower.contains("defender") || lower.contains("piece") || lower.contains("king"))
    }

    @Test("factor has name and value")
    func factorStructure() {
        let factor = ExplanationFactor(name: "Mobility", value: 5, description: "Increases mobility")
        #expect(factor.name == "Mobility")
        #expect(factor.value == 5)
        #expect(!factor.description.isEmpty)
    }

    @Test("ExplanationFactor is Equatable")
    func factorEquatable() {
        let a = ExplanationFactor(name: "Test", value: 1, description: "d")
        let b = ExplanationFactor(name: "Test", value: 1, description: "d")
        #expect(a == b)
    }

    @Test("MoveExplanationResult is Equatable")
    func resultEquatable() {
        let a = MoveExplanationResult(text: "t", score: 1, factors: [])
        let b = MoveExplanationResult(text: "t", score: 1, factors: [])
        #expect(a == b)
    }
}
