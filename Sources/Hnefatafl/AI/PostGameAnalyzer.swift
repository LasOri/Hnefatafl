enum MoveClassification: Int, Equatable {
    case excellent = 0
    case good = 1
    case inaccuracy = 2
    case blunder = 3
}

struct MoveEvaluation: Equatable {
    let move: Move
    let player: Player
    let scoreBefore: Int
    let scoreAfter: Int
    let classification: MoveClassification
}

struct MaterialSnapshot: Equatable {
    let attackerCount: Int
    let defenderCount: Int
}

struct GameAnalysis: Equatable {
    let moveEvaluations: [MoveEvaluation]
    let materialBalance: [MaterialSnapshot]
    let worstBlunderIndex: Int?
}

enum PostGameAnalyzer {
    static func analyze(game: Game) -> GameAnalysis {
        guard !game.moveHistory.isEmpty else {
            return GameAnalysis(moveEvaluations: [], materialBalance: [], worstBlunderIndex: nil)
        }

        var evaluations: [MoveEvaluation] = []
        var materialSnapshots: [MaterialSnapshot] = []

        var currentGame = Game()
        materialSnapshots.append(MaterialSnapshot(
            attackerCount: currentGame.position.attackerCount,
            defenderCount: currentGame.position.defenderCount
        ))

        var worstDelta = 0
        var worstIndex: Int? = nil

        for (index, move) in game.moveHistory.enumerated() {
            let player = currentGame.currentPlayer
            let scoreBefore = EvaluationAI.evaluate(position: currentGame.position, for: player)

            currentGame = currentGame.makeMove(move)
            let scoreAfter = EvaluationAI.evaluate(position: currentGame.position, for: player)

            let delta = scoreAfter - scoreBefore
            let classification = classify(delta: delta)

            evaluations.append(MoveEvaluation(
                move: move,
                player: player,
                scoreBefore: scoreBefore,
                scoreAfter: scoreAfter,
                classification: classification
            ))

            materialSnapshots.append(MaterialSnapshot(
                attackerCount: currentGame.position.attackerCount,
                defenderCount: currentGame.position.defenderCount
            ))

            if classification == .blunder {
                let absDelta = abs(delta)
                if absDelta > worstDelta {
                    worstDelta = absDelta
                    worstIndex = index
                }
            }
        }

        return GameAnalysis(
            moveEvaluations: evaluations,
            materialBalance: materialSnapshots,
            worstBlunderIndex: worstIndex
        )
    }

    private static func classify(delta: Int) -> MoveClassification {
        if delta >= 50 { return .excellent }
        if delta >= -20 { return .good }
        if delta >= -100 { return .inaccuracy }
        return .blunder
    }
}
