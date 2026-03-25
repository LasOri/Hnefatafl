enum ComplexityLevel: Equatable {
    case low
    case medium
    case high
}

struct ComplexityInfo: Equatable {
    let branchingFactor: Int
    let totalMoves: Int
    let pieceDensity: Double
    let level: ComplexityLevel
}

enum GameComplexity {
    static func complexity(position: Position) -> ComplexityInfo {
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        let totalMoves = attackerMoves + defenderMoves

        let totalPieces = position.attackerCount + position.defenderCount + (hasKing(position: position) ? 1 : 0)
        let branchingFactor = totalPieces > 0 ? totalMoves / totalPieces : 0

        let maxSquares = Position.boardSize * Position.boardSize
        let pieceDensity = Double(totalPieces) / Double(maxSquares)

        let level = classifyComplexity(branchingFactor: branchingFactor, totalMoves: totalMoves)

        return ComplexityInfo(
            branchingFactor: branchingFactor,
            totalMoves: totalMoves,
            pieceDensity: pieceDensity,
            level: level
        )
    }

    private static func hasKing(position: Position) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return true
                }
            }
        }
        return false
    }

    private static func classifyComplexity(branchingFactor: Int, totalMoves: Int) -> ComplexityLevel {
        if branchingFactor < 5 || totalMoves < 30 {
            return .low
        } else if branchingFactor < 10 || totalMoves < 80 {
            return .medium
        } else {
            return .high
        }
    }
}
