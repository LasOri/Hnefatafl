enum PositionClass: String, CaseIterable, Equatable {
    case quiet
    case tactical
    case sharp
    case endgame
}

enum PositionClassifier {
    static func classify(position: Position) -> PositionClass {
        let totalPieces = position.attackerCount + position.defenderCount

        if totalPieces <= 8 {
            return .endgame
        }

        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        let totalMoves = attackerMoves + defenderMoves

        let threats = countMutualThreats(position: position)

        if threats >= 6 {
            return .sharp
        }

        if threats >= 3 || totalMoves > 100 {
            return .tactical
        }

        return .quiet
    }

    private static func countMutualThreats(position: Position) -> Int {
        var threats = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }

                let enemyPieces: [Piece]
                if piece == .attacker {
                    enemyPieces = [.defender, .king]
                } else {
                    enemyPieces = [.attacker]
                }

                let adjacents = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
                for adj in adjacents {
                    guard adj.0 >= 0 && adj.0 < Position.boardSize && adj.1 >= 0 && adj.1 < Position.boardSize else {
                        continue
                    }
                    if let adjPiece = position.pieceAt(row: adj.0, col: adj.1), enemyPieces.contains(adjPiece) {
                        threats += 1
                    }
                }
            }
        }

        return threats / 2
    }
}
