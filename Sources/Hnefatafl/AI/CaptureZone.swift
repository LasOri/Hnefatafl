enum CaptureZone {
    static func hotspots(position: Position) -> [(row: Int, col: Int)] {
        let size = Position.boardSize
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var result: [(row: Int, col: Int)] = []

        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col), piece != .king else { continue }
                let isAttackerSide = piece.isAttackerSide
                var adjacentEnemies = 0
                var emptyAdjacent = false

                for (dr, dc) in directions {
                    let r = row + dr
                    let c = col + dc
                    guard r >= 0, r < size, c >= 0, c < size else { continue }
                    if let neighbor = position.pieceAt(row: r, col: c) {
                        let neighborIsAttacker = neighbor.isAttackerSide
                        if isAttackerSide != neighborIsAttacker {
                            adjacentEnemies += 1
                        }
                    } else {
                        emptyAdjacent = true
                    }
                }

                if adjacentEnemies >= 1 && emptyAdjacent {
                    result.append((row: row, col: col))
                }
            }
        }
        return result
    }

    static func hotspotCount(position: Position) -> Int {
        hotspots(position: position).count
    }
}
