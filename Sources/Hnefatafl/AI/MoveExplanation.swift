struct ExplanationFactor: Equatable {
    let name: String
    let value: Int
    let description: String
}

struct MoveExplanationResult: Equatable {
    let text: String
    let score: Int
    let factors: [ExplanationFactor]
}

enum MoveExplanation {
    static func explain(move: Move, in game: Game) -> MoveExplanationResult {
        let piece = game.position.pieceAt(row: move.fromRow, col: move.fromCol)
        let pieceName = pieceLabel(piece, player: game.currentPlayer)

        let scoreBefore = EvaluationAI.evaluate(position: game.position, for: game.currentPlayer)
        let newPosition = game.position.applyMove(move)
        let scoreAfter = EvaluationAI.evaluate(position: newPosition, for: game.currentPlayer)
        let delta = scoreAfter - scoreBefore

        var factors: [ExplanationFactor] = []

        let mobilityBefore = game.position.allLegalMoves(for: game.currentPlayer).count
        let mobilityAfter = newPosition.allLegalMoves(for: game.currentPlayer).count
        let mobilityDelta = mobilityAfter - mobilityBefore
        if mobilityDelta != 0 {
            factors.append(ExplanationFactor(
                name: "Mobility",
                value: mobilityDelta,
                description: mobilityDelta > 0 ? "Increases available moves" : "Reduces available moves"
            ))
        }

        let capturesBefore = game.position.defenderCount + game.position.attackerCount
        let capturesAfter = newPosition.defenderCount + newPosition.attackerCount
        if capturesAfter < capturesBefore {
            factors.append(ExplanationFactor(
                name: "Capture",
                value: capturesBefore - capturesAfter,
                description: "Captures \(capturesBefore - capturesAfter) piece(s)"
            ))
        }

        if piece == .king {
            let fromDist = minCornerDistance(row: move.fromRow, col: move.fromCol)
            let toDist = minCornerDistance(row: move.toRow, col: move.toCol)
            if toDist < fromDist {
                factors.append(ExplanationFactor(
                    name: "King Advance",
                    value: fromDist - toDist,
                    description: "Moves king closer to corner escape"
                ))
            }
        }

        if factors.isEmpty {
            factors.append(ExplanationFactor(
                name: "Positioning",
                value: delta,
                description: "Improves board position"
            ))
        }

        let from = AlgebraicNotation.squareName(row: move.fromRow, col: move.fromCol)
        let to = AlgebraicNotation.squareName(row: move.toRow, col: move.toCol)
        let summary = factors.map(\.description).joined(separator: ". ")
        let text = "\(pieceName) moves \(from) to \(to). \(summary)."

        return MoveExplanationResult(text: text, score: delta, factors: factors)
    }

    private static func pieceLabel(_ piece: Piece?, player: Player) -> String {
        switch piece {
        case .king: return "King"
        case .defender: return "Defender piece"
        case .attacker: return "Attacker piece"
        case nil: return player == .attacker ? "Attacker piece" : "Defender piece"
        }
    }

    private static func minCornerDistance(row: Int, col: Int) -> Int {
        [(0,0),(0,10),(10,0),(10,10)].map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
    }
}
