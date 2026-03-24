enum GamePhase: Equatable {
    case opening
    case midgame
    case endgame
}

struct EndgameDetector {
    static let endgameThreshold = 8
    static let midgameThreshold = 20

    static func phase(position: Position) -> GamePhase {
        let count = pieceCount(position: position)
        if count <= endgameThreshold { return .endgame }
        if count <= midgameThreshold { return .midgame }
        return .opening
    }

    static func pieceCount(position: Position) -> Int {
        position.cells.compactMap({ $0 }).count
    }
}
