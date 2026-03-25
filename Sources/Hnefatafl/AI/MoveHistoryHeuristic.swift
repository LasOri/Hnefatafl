struct MoveHistoryHeuristic: Equatable {
    private var scores: [Int: Int] = [:]

    mutating func recordSuccess(move: Move, depth: Int) {
        let key = moveKey(move)
        scores[key, default: 0] += depth * depth
    }

    func score(for move: Move) -> Int {
        scores[moveKey(move)] ?? 0
    }

    mutating func age() {
        for key in scores.keys {
            scores[key] = scores[key].map { $0 / 2 }
        }
    }

    var totalEntries: Int { scores.count }

    private func moveKey(_ move: Move) -> Int {
        move.fromRow * 1331 + move.fromCol * 121 + move.toRow * 11 + move.toCol
    }
}
