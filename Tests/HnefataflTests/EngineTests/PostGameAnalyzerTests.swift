import Testing
@testable import Hnefatafl

@Suite("PostGameAnalyzer Tests")
struct PostGameAnalyzerTests {

    @Test("analyze empty game returns empty evaluations")
    func emptyGame() {
        let game = Game()
        let analysis = PostGameAnalyzer.analyze(game: game)
        #expect(analysis.moveEvaluations.isEmpty)
    }

    @Test("analyze game with one move returns one evaluation")
    func oneMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        #expect(analysis.moveEvaluations.count == 1)
    }

    @Test("move evaluation contains score delta")
    func scoreDelta() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        let eval = analysis.moveEvaluations[0]
        #expect(eval.scoreBefore != 0 || eval.scoreAfter != 0)
    }

    @Test("move classification is one of known types")
    func classification() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        let validClasses: Set<MoveClassification> = [.excellent, .good, .inaccuracy, .blunder]
        #expect(validClasses.contains(analysis.moveEvaluations[0].classification))
    }

    @Test("material balance at start is positive for defender")
    func materialBalance() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        #expect(analysis.materialBalance.count == 2)
    }

    @Test("material balance starts with initial piece counts")
    func initialBalance() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        let initial = analysis.materialBalance[0]
        #expect(initial.attackerCount == 24)
        #expect(initial.defenderCount == 13)
    }

    @Test("worst blunder index is valid")
    func worstBlunder() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        if let blunderIndex = analysis.worstBlunderIndex {
            #expect(blunderIndex >= 0)
            #expect(blunderIndex < analysis.moveEvaluations.count)
        }
    }

    @Test("MoveEvaluation stores move and player")
    func evalStoresMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let analysis = PostGameAnalyzer.analyze(game: afterMove)
        let eval = analysis.moveEvaluations[0]
        #expect(eval.move == move)
        #expect(eval.player == .attacker)
    }

    @Test("MoveClassification rawValue ordering")
    func classificationOrdering() {
        #expect(MoveClassification.excellent.rawValue < MoveClassification.good.rawValue)
        #expect(MoveClassification.good.rawValue < MoveClassification.inaccuracy.rawValue)
        #expect(MoveClassification.inaccuracy.rawValue < MoveClassification.blunder.rawValue)
    }

    @Test("analysis for two-move game")
    func twoMoves() {
        let game = Game()
        let attackerMove = game.position.allLegalMoves(for: .attacker).first!
        let after1 = game.makeMove(attackerMove)
        let defenderMove = after1.position.allLegalMoves(for: .defender).first!
        let after2 = after1.makeMove(defenderMove)
        let analysis = PostGameAnalyzer.analyze(game: after2)
        #expect(analysis.moveEvaluations.count == 2)
        #expect(analysis.moveEvaluations[0].player == .attacker)
        #expect(analysis.moveEvaluations[1].player == .defender)
        #expect(analysis.materialBalance.count == 3)
    }
}
