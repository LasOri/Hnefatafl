struct RepetitionChecker {
    static let threefoldThreshold = 3

    static func count(position: Position, in game: Game) -> Int {
        countIn(position: position, history: game.positionHistory)
    }

    static func countIn(position: Position, history: [Position]) -> Int {
        history.filter { $0 == position }.count
    }

    static func isThreefold(position: Position, history: [Position]) -> Bool {
        isRepeated(position: position, history: history, threshold: threefoldThreshold)
    }

    static func isRepeated(position: Position, history: [Position], threshold: Int) -> Bool {
        countIn(position: position, history: history) >= threshold
    }
}
