import Foundation

enum DispersionIndex {
    static func index(position: Position, player: Player) -> Double {
        let coords = pieceCoordinates(position: position, player: player)
        guard coords.count >= 2 else { return 0 }

        var totalDist = 0.0
        var pairCount = 0
        for i in 0..<coords.count {
            for j in (i + 1)..<coords.count {
                let dr = Double(coords[i].0 - coords[j].0)
                let dc = Double(coords[i].1 - coords[j].1)
                totalDist += sqrt(dr * dr + dc * dc)
                pairCount += 1
            }
        }
        return totalDist / Double(pairCount)
    }

    static func isCompact(position: Position, player: Player) -> Bool {
        index(position: position, player: player) < 3.5
    }

    private static func pieceCoordinates(position: Position, player: Player) -> [(Int, Int)] {
        var coords: [(Int, Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                switch piece {
                case .attacker where player == .attacker:
                    coords.append((row, col))
                case .defender where player == .defender:
                    coords.append((row, col))
                case .king where player == .defender:
                    coords.append((row, col))
                default:
                    break
                }
            }
        }
        return coords
    }
}
