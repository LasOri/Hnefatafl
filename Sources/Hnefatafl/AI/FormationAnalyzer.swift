struct FormationAnalyzer {
    static func areAdjacent(r1: Int, c1: Int, r2: Int, c2: Int) -> Bool {
        abs(r1 - r2) + abs(c1 - c2) == 1
    }

    static func attackerClusters(position: Position) -> Int {
        var visited = Set<Int>()
        var clusters = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let idx = row * Position.boardSize + col
                if position.pieceAt(row: row, col: col) == .attacker && !visited.contains(idx) {
                    clusters += 1
                    floodFill(position: position, row: row, col: col, piece: .attacker, visited: &visited)
                }
            }
        }
        return clusters
    }

    static func defenderWalls(position: Position) -> Int {
        var walls = 0
        for row in 0..<Position.boardSize {
            var consecutive = 0
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .defender || piece == .king {
                    consecutive += 1
                    if consecutive >= 3 { walls += 1 }
                } else {
                    consecutive = 0
                }
            }
        }
        return walls
    }

    static func isolatedPieces(position: Position, player: Player) -> Int {
        let targetPiece: Piece = player == .attacker ? .attacker : .defender
        var isolated = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                guard piece == targetPiece || (player == .defender && piece == .king) else { continue }
                let neighbors = [(row-1, col), (row+1, col), (row, col-1), (row, col+1)]
                let hasAlly = neighbors.contains { r, c in
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { return false }
                    let p = position.pieceAt(row: r, col: c)
                    if player == .defender { return p == .defender || p == .king }
                    return p == targetPiece
                }
                if !hasAlly { isolated += 1 }
            }
        }
        return isolated
    }

    static func connectedPieces(position: Position, player: Player) -> Int {
        let targetPiece: Piece = player == .attacker ? .attacker : .defender
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                guard piece == targetPiece || (player == .defender && piece == .king) else { continue }
                let neighbors = [(row-1, col), (row+1, col), (row, col-1), (row, col+1)]
                let hasAlly = neighbors.contains { r, c in
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { return false }
                    let p = position.pieceAt(row: r, col: c)
                    if player == .defender { return p == .defender || p == .king }
                    return p == targetPiece
                }
                if hasAlly { count += 1 }
            }
        }
        return count
    }

    static func score(position: Position, player: Player) -> Int {
        let connected = connectedPieces(position: position, player: player)
        let isolated = isolatedPieces(position: position, player: player)
        return connected * 3 - isolated * 5
    }

    private static func floodFill(position: Position, row: Int, col: Int, piece: Piece, visited: inout Set<Int>) {
        let idx = row * Position.boardSize + col
        guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else { return }
        guard !visited.contains(idx) else { return }
        guard position.pieceAt(row: row, col: col) == piece else { return }
        visited.insert(idx)
        floodFill(position: position, row: row - 1, col: col, piece: piece, visited: &visited)
        floodFill(position: position, row: row + 1, col: col, piece: piece, visited: &visited)
        floodFill(position: position, row: row, col: col - 1, piece: piece, visited: &visited)
        floodFill(position: position, row: row, col: col + 1, piece: piece, visited: &visited)
    }
}
