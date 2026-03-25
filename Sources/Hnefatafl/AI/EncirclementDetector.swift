struct EncirclementDetector {
    static func isKingEncircled(position: Position) -> Bool {
        let size = Position.boardSize
        guard let kingPos = findKing(position: position) else { return false }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var blockedCount = 0

        for (dr, dc) in directions {
            let nr = kingPos.row + dr
            let nc = kingPos.col + dc
            if nr < 0 || nr >= size || nc < 0 || nc >= size {
                blockedCount += 1
            } else if position.cells[nr * size + nc] == .attacker {
                blockedCount += 1
            }
        }

        return blockedCount >= 4 || (blockedCount >= directions.count)
    }

    static func adjacentAttackers(position: Position) -> Int {
        let size = Position.boardSize
        guard let kingPos = findKing(position: position) else { return 0 }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var count = 0
        for (dr, dc) in directions {
            let nr = kingPos.row + dr
            let nc = kingPos.col + dc
            if nr >= 0 && nr < size && nc >= 0 && nc < size {
                if position.cells[nr * size + nc] == .attacker {
                    count += 1
                }
            }
        }
        return count
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        let size = Position.boardSize
        for i in 0..<(size * size) {
            if position.cells[i] == .king {
                return (row: i / size, col: i % size)
            }
        }
        return nil
    }
}
