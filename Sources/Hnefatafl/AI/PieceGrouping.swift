struct PieceGroup: Equatable {
    let squares: [(Int, Int)]
    let size: Int

    static func == (lhs: PieceGroup, rhs: PieceGroup) -> Bool {
        lhs.size == rhs.size && lhs.squares.count == rhs.squares.count
    }
}

enum PieceGrouping {
    static func find(position: Position, for player: Player) -> [PieceGroup] {
        var visited = Array(repeating: false, count: 121)
        var groups: [PieceGroup] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let idx = row * 11 + col
                guard !visited[idx] else { continue }
                let piece = position.pieceAt(row: row, col: col)
                let isFriendly: Bool
                if player == .attacker {
                    isFriendly = piece == .attacker
                } else {
                    isFriendly = piece == .defender || piece == .king
                }
                guard isFriendly else { continue }

                var groupSquares: [(Int, Int)] = []
                var stack = [(row, col)]
                visited[idx] = true

                while !stack.isEmpty {
                    let (r, c) = stack.removeLast()
                    groupSquares.append((r, c))

                    let neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)]
                    for (nr, nc) in neighbors {
                        guard nr >= 0, nr < Position.boardSize, nc >= 0, nc < Position.boardSize else { continue }
                        let nIdx = nr * 11 + nc
                        guard !visited[nIdx] else { continue }
                        let nPiece = position.pieceAt(row: nr, col: nc)
                        let nFriendly: Bool
                        if player == .attacker {
                            nFriendly = nPiece == .attacker
                        } else {
                            nFriendly = nPiece == .defender || nPiece == .king
                        }
                        if nFriendly {
                            visited[nIdx] = true
                            stack.append((nr, nc))
                        }
                    }
                }

                groups.append(PieceGroup(squares: groupSquares, size: groupSquares.count))
            }
        }

        return groups
    }
}
