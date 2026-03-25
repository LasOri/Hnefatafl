struct ClusterInfo: Equatable {
    let count: Int
    let maxSize: Int
    let averageSize: Double
}

enum PieceCluster {
    static func analyze(position: Position, player: Player) -> ClusterInfo {
        var visited = Set<Int>()
        var clusters: [Int] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let idx = row * Position.boardSize + col
                guard !visited.contains(idx) else { continue }
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                let size = flood(row: row, col: col, position: position, player: player, visited: &visited)
                clusters.append(size)
            }
        }
        let total = clusters.count
        let maxS = clusters.max() ?? 0
        let avg = total > 0 ? Double(clusters.reduce(0, +)) / Double(total) : 0
        return ClusterInfo(count: total, maxSize: maxS, averageSize: avg)
    }

    private static func flood(row: Int, col: Int, position: Position, player: Player, visited: inout Set<Int>) -> Int {
        guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else { return 0 }
        let idx = row * Position.boardSize + col
        guard !visited.contains(idx) else { return 0 }
        guard let piece = position.pieceAt(row: row, col: col) else { return 0 }
        let isP: Bool
        switch piece {
        case .attacker: isP = player == .attacker
        case .defender, .king: isP = player == .defender
        }
        guard isP else { return 0 }
        visited.insert(idx)
        var s = 1
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            s += flood(row: row + dr, col: col + dc, position: position, player: player, visited: &visited)
        }
        return s
    }
}
