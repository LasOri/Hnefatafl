enum PieceConnectivity {
    static func connectedGroups(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var visited = Array(repeating: false, count: size * size)
        var groupCount = 0

        for row in 0..<size {
            for col in 0..<size {
                let idx = row * size + col
                guard !visited[idx] else { continue }
                guard let piece = position.pieceAt(row: row, col: col),
                      belongsTo(piece: piece, player: player) else { continue }
                floodFill(position: position, player: player, row: row, col: col, visited: &visited)
                groupCount += 1
            }
        }
        return groupCount
    }

    static func largestGroupSize(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var visited = Array(repeating: false, count: size * size)
        var largest = 0

        for row in 0..<size {
            for col in 0..<size {
                let idx = row * size + col
                guard !visited[idx] else { continue }
                guard let piece = position.pieceAt(row: row, col: col),
                      belongsTo(piece: piece, player: player) else { continue }
                let groupSize = floodFill(position: position, player: player, row: row, col: col, visited: &visited)
                if groupSize > largest { largest = groupSize }
            }
        }
        return largest
    }

    @discardableResult
    private static func floodFill(position: Position, player: Player, row: Int, col: Int, visited: inout [Bool]) -> Int {
        let size = Position.boardSize
        let idx = row * size + col
        guard row >= 0, row < size, col >= 0, col < size else { return 0 }
        guard !visited[idx] else { return 0 }
        guard let piece = position.pieceAt(row: row, col: col),
              belongsTo(piece: piece, player: player) else { return 0 }
        visited[idx] = true
        var count = 1
        count += floodFill(position: position, player: player, row: row - 1, col: col, visited: &visited)
        count += floodFill(position: position, player: player, row: row + 1, col: col, visited: &visited)
        count += floodFill(position: position, player: player, row: row, col: col - 1, visited: &visited)
        count += floodFill(position: position, player: player, row: row, col: col + 1, visited: &visited)
        return count
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch player {
        case .attacker: return piece.isAttackerSide
        case .defender: return piece.isDefenderSide
        }
    }
}
