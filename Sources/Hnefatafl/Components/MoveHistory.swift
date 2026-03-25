struct MoveHistoryEntry: Equatable {
    let index: Int
    let move: Move
    let player: Player
    let notation: String
}

enum MoveHistoryFormatter {
    static func format(moves: [Move]) -> [MoveHistoryEntry] {
        moves.enumerated().map { idx, move in
            let player: Player = idx % 2 == 0 ? .attacker : .defender
            let fromCol = String(UnicodeScalar(97 + move.fromCol)!)
            let toCol = String(UnicodeScalar(97 + move.toCol)!)
            let notation = "\(fromCol)\(Position.boardSize - move.fromRow)-\(toCol)\(Position.boardSize - move.toRow)"
            return MoveHistoryEntry(index: idx, move: move, player: player, notation: notation)
        }
    }
}
