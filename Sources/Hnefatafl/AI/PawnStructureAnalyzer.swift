enum PawnStructureAnalyzer {
    static func isolatedCount(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayerPiece: Bool
                switch piece {
                case .attacker: isPlayerPiece = player == .attacker
                case .defender, .king: isPlayerPiece = player == .defender
                }
                guard isPlayerPiece else { continue }
                if !hasAdjacentFriendly(row: row, col: col, position: position, player: player) {
                    count += 1
                }
            }
        }
        return count
    }

    static func chainLength(position: Position, player: Player) -> Int {
        var visited = Set<Int>()
        var maxChain = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let idx = row * Position.boardSize + col
                guard !visited.contains(idx) else { continue }
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayerPiece: Bool
                switch piece {
                case .attacker: isPlayerPiece = player == .attacker
                case .defender, .king: isPlayerPiece = player == .defender
                }
                guard isPlayerPiece else { continue }
                let size = floodFill(row: row, col: col, position: position, player: player, visited: &visited)
                maxChain = max(maxChain, size)
            }
        }
        return maxChain
    }

    private static func hasAdjacentFriendly(row: Int, col: Int, position: Position, player: Player) -> Bool {
        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in dirs {
            let r = row + dr, c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c) {
                let isPlayerPiece: Bool
                switch piece {
                case .attacker: isPlayerPiece = player == .attacker
                case .defender, .king: isPlayerPiece = player == .defender
                }
                if isPlayerPiece { return true }
            }
        }
        return false
    }

    private static func floodFill(row: Int, col: Int, position: Position, player: Player, visited: inout Set<Int>) -> Int {
        let idx = row * Position.boardSize + col
        guard !visited.contains(idx) else { return 0 }
        guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else { return 0 }
        guard let piece = position.pieceAt(row: row, col: col) else { return 0 }
        let isPlayerPiece: Bool
        switch piece {
        case .attacker: isPlayerPiece = player == .attacker
        case .defender, .king: isPlayerPiece = player == .defender
        }
        guard isPlayerPiece else { return 0 }
        visited.insert(idx)
        var size = 1
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            size += floodFill(row: row + dr, col: col + dc, position: position, player: player, visited: &visited)
        }
        return size
    }
}
