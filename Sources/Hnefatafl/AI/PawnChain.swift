enum PawnChain {
    static func longestChain(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var visited = Array(repeating: false, count: size * size)
        var longest = 0

        for row in 0..<size {
            for col in 0..<size {
                let idx = row * size + col
                guard !visited[idx] else { continue }
                guard let piece = position.pieceAt(row: row, col: col),
                      belongsTo(piece: piece, player: player) else { continue }
                let chainLen = measureChain(position: position, player: player, row: row, col: col, visited: &visited)
                if chainLen > longest { longest = chainLen }
            }
        }
        return longest
    }

    static func chainCount(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var visited = Array(repeating: false, count: size * size)
        var count = 0

        for row in 0..<size {
            for col in 0..<size {
                let idx = row * size + col
                guard !visited[idx] else { continue }
                guard let piece = position.pieceAt(row: row, col: col),
                      belongsTo(piece: piece, player: player) else { continue }
                let chainLen = measureChain(position: position, player: player, row: row, col: col, visited: &visited)
                if chainLen >= 2 { count += 1 }
            }
        }
        return count
    }

    private static func measureChain(position: Position, player: Player, row: Int, col: Int, visited: inout [Bool]) -> Int {
        let size = Position.boardSize
        let idx = row * size + col
        guard row >= 0, row < size, col >= 0, col < size else { return 0 }
        guard !visited[idx] else { return 0 }
        guard let piece = position.pieceAt(row: row, col: col),
              belongsTo(piece: piece, player: player) else { return 0 }
        visited[idx] = true
        var count = 1
        count += measureChain(position: position, player: player, row: row - 1, col: col, visited: &visited)
        count += measureChain(position: position, player: player, row: row + 1, col: col, visited: &visited)
        count += measureChain(position: position, player: player, row: row, col: col - 1, visited: &visited)
        count += measureChain(position: position, player: player, row: row, col: col + 1, visited: &visited)
        return count
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch player {
        case .attacker: return piece.isAttackerSide
        case .defender: return piece.isDefenderSide
        }
    }
}
