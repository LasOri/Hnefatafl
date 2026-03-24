enum BoardPattern: Equatable {
    case edgeWall
    case cornerControl
    case kingNearEdge
    case centralFortress

    var label: String {
        switch self {
        case .edgeWall: return "Edge Wall"
        case .cornerControl: return "Corner Control"
        case .kingNearEdge: return "King Near Edge"
        case .centralFortress: return "Central Fortress"
        }
    }
}

struct BoardPatternDetector {
    static func detect(position: Position) -> [BoardPattern] {
        var patterns: [BoardPattern] = []
        if hasEdgeWall(position: position) { patterns.append(.edgeWall) }
        if hasCornerControl(position: position) { patterns.append(.cornerControl) }
        if hasKingNearEdge(position: position) { patterns.append(.kingNearEdge) }
        if hasCentralFortress(position: position) { patterns.append(.centralFortress) }
        return patterns
    }

    private static func hasEdgeWall(position: Position) -> Bool {
        let size = Position.boardSize
        let edges: [[Int]] = [
            (0..<size).map { $0 },
            (0..<size).map { (size - 1) * size + $0 },
            (0..<size).map { $0 * size },
            (0..<size).map { $0 * size + (size - 1) }
        ]
        for edge in edges {
            let count = edge.filter { position.cells[$0] == .attacker }.count
            if count >= 3 { return true }
        }
        return false
    }

    private static func hasCornerControl(position: Position) -> Bool {
        let size = Position.boardSize
        let corners = [(0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1)]
        for (r, c) in corners {
            let adjacent = [(r, c + 1), (r + 1, c), (r, c - 1), (r - 1, c)]
            let attackersNear = adjacent.filter { pos in
                guard pos.0 >= 0 && pos.0 < size && pos.1 >= 0 && pos.1 < size else { return false }
                return position.cells[pos.0 * size + pos.1] == .attacker
            }.count
            if attackersNear >= 2 { return true }
        }
        return false
    }

    private static func hasKingNearEdge(position: Position) -> Bool {
        let size = Position.boardSize
        for i in 0..<(size * size) {
            if position.cells[i] == .king {
                let row = i / size
                let col = i % size
                if row <= 1 || row >= size - 2 || col <= 1 || col >= size - 2 {
                    return true
                }
            }
        }
        return false
    }

    private static func hasCentralFortress(position: Position) -> Bool {
        let size = Position.boardSize
        for i in 0..<(size * size) {
            if position.cells[i] == .king {
                let row = i / size
                let col = i % size
                let adjacent = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
                let defenderCount = adjacent.filter { pos in
                    guard pos.0 >= 0 && pos.0 < size && pos.1 >= 0 && pos.1 < size else { return false }
                    return position.cells[pos.0 * size + pos.1] == .defender
                }.count
                if defenderCount == 4 { return true }
            }
        }
        return false
    }
}
