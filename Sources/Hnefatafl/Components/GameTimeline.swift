struct TimelineEntry: Equatable {
    let moveIndex: Int
    let player: Player
    let notation: String
}

struct GameTimeline: Equatable {
    private(set) var entries: [TimelineEntry] = []

    mutating func addMove(index: Int, player: Player, move: Move) {
        let fromCol = String(UnicodeScalar(97 + move.fromCol)!)
        let toCol = String(UnicodeScalar(97 + move.toCol)!)
        let notation = "\(fromCol)\(Position.boardSize - move.fromRow)-\(toCol)\(Position.boardSize - move.toRow)"
        entries.append(TimelineEntry(moveIndex: index, player: player, notation: notation))
    }

    var count: Int { entries.count }
    var lastMove: TimelineEntry? { entries.last }
}
