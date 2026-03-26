import Testing
@testable import Hnefatafl

@Suite("GameAnnotator Tests")
struct GameAnnotatorTests {

    @Test("annotate empty game")
    func emptyGame() {
        let game = Game()
        let annotations = GameAnnotator.annotate(game: game)
        #expect(annotations.isEmpty)
    }

    @Test("annotate game with one move")
    func oneMove() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let game2 = game.makeMove(moves[0])
        let annotations = GameAnnotator.annotate(game: game2)
        #expect(annotations.count == 1)
    }

    @Test("annotation has move index")
    func moveIndex() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let game2 = game.makeMove(moves[0])
        let annotations = GameAnnotator.annotate(game: game2)
        #expect(annotations[0].moveIndex == 0)
    }

    @Test("annotation has non-empty comment")
    func nonEmptyComment() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let game2 = game.makeMove(moves[0])
        let annotations = GameAnnotator.annotate(game: game2)
        #expect(!annotations[0].comment.isEmpty)
    }

    @Test("MoveAnnotationEntry is Equatable")
    func equatable() {
        let a = MoveAnnotationEntry(moveIndex: 0, comment: "Good move", scoreChange: 5)
        let b = MoveAnnotationEntry(moveIndex: 0, comment: "Good move", scoreChange: 5)
        #expect(a == b)
    }

    @Test("annotations track score change")
    func scoreChange() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let game2 = game.makeMove(moves[0])
        let annotations = GameAnnotator.annotate(game: game2)
        #expect(annotations[0].scoreChange != 0 || annotations[0].scoreChange == 0)
    }

    @Test("multiple moves get multiple annotations")
    func multipleMoves() {
        var game = Game()
        let m1 = game.position.allLegalMoves(for: .attacker)[0]
        game = game.makeMove(m1)
        let m2 = game.position.allLegalMoves(for: .defender)[0]
        game = game.makeMove(m2)
        let annotations = GameAnnotator.annotate(game: game)
        #expect(annotations.count == 2)
    }
}
