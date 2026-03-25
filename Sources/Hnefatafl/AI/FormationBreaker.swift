enum FormationBreaker {
    static func breakingMoves(position: Position, player: Player) -> [Move] {
        let moves = position.allLegalMoves(for: player)
        let opponent: Player = player == .attacker ? .defender : .attacker
        let currentAdjacency = totalAdjacency(position: position, player: opponent)
        var result: [Move] = []

        for move in moves {
            let newPos = position.applyMove(move)
            let newAdjacency = totalAdjacency(position: newPos, player: opponent)
            if newAdjacency < currentAdjacency {
                result.append(move)
            }
        }

        return result
    }

    static func breakingMoveCount(position: Position, player: Player) -> Int {
        breakingMoves(position: position, player: player).count
    }

    private static func totalAdjacency(position: Position, player: Player) -> Int {
        var total = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard matchesPiece(position.pieceAt(row: row, col: col), player: player) else { continue }
                for (dr, dc) in directions {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if matchesPiece(position.pieceAt(row: r, col: c), player: player) {
                        total += 1
                    }
                }
            }
        }

        return total
    }

    private static func matchesPiece(_ piece: Piece?, player: Player) -> Bool {
        guard let piece = piece else { return false }
        switch player {
        case .attacker:
            return piece == .attacker
        case .defender:
            return piece == .defender || piece == .king
        }
    }
}
