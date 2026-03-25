struct RepetitionDetector: Equatable {
    private var positionHashes: [String] = []

    mutating func record(position: Position) {
        positionHashes.append(PositionSerializer.serialize(position: position))
    }

    func count(for position: Position) -> Int {
        let hash = PositionSerializer.serialize(position: position)
        return positionHashes.filter { $0 == hash }.count
    }

    func isThreefoldRepetition(position: Position) -> Bool {
        count(for: position) >= 3
    }

    var totalPositions: Int { positionHashes.count }

    mutating func reset() {
        positionHashes.removeAll()
    }
}
