enum FormationShape: String, CaseIterable, Equatable {
    case line
    case cluster
    case arc
    case scattered
}

enum PieceFormationShape {
    static func classify(position: Position, player: Player) -> FormationShape {
        let pieces = collectPieces(position: position, player: player)

        guard pieces.count >= 2 else {
            return .scattered
        }

        if isLine(pieces) {
            return .line
        }

        if isCluster(pieces) {
            return .cluster
        }

        if isArc(pieces) {
            return .arc
        }

        return .scattered
    }

    private static func collectPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), targetPieces.contains(piece) {
                    result.append((row, col))
                }
            }
        }

        return result
    }

    private static func isLine(_ pieces: [(row: Int, col: Int)]) -> Bool {
        guard pieces.count >= 3 else { return false }

        let sameRow = pieces.allSatisfy { $0.row == pieces[0].row }
        let sameCol = pieces.allSatisfy { $0.col == pieces[0].col }

        return sameRow || sameCol
    }

    private static func isCluster(_ pieces: [(row: Int, col: Int)]) -> Bool {
        guard pieces.count >= 2 else { return false }

        var adjacencyCount = 0
        for i in 0..<pieces.count {
            for j in (i + 1)..<pieces.count {
                let distance = abs(pieces[i].row - pieces[j].row) + abs(pieces[i].col - pieces[j].col)
                if distance == 1 {
                    adjacencyCount += 1
                }
            }
        }

        return adjacencyCount >= pieces.count - 1
    }

    private static func isArc(_ pieces: [(row: Int, col: Int)]) -> Bool {
        guard pieces.count >= 3 else { return false }

        let avgRow = pieces.map(\.row).reduce(0, +) / pieces.count
        let avgCol = pieces.map(\.col).reduce(0, +) / pieces.count

        var distances: [Int] = []
        for p in pieces {
            distances.append(abs(p.row - avgRow) + abs(p.col - avgCol))
        }

        guard let minD = distances.min(), let maxD = distances.max() else { return false }
        return maxD - minD <= 2 && minD > 0
    }
}
