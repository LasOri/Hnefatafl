struct HistoryTable {
    private var scores: [MoveKey: Int] = [:]

    private struct MoveKey: Hashable {
        let fromRow: Int
        let fromCol: Int
        let toRow: Int
        let toCol: Int

        init(_ move: Move) {
            fromRow = move.fromRow
            fromCol = move.fromCol
            toRow = move.toRow
            toCol = move.toCol
        }
    }

    mutating func record(move: Move, depth: Int) {
        let key = MoveKey(move)
        scores[key, default: 0] += depth * depth
    }

    func score(for move: Move) -> Int {
        scores[MoveKey(move)] ?? 0
    }

    func sorted(moves: [Move]) -> [Move] {
        moves.sorted { score(for: $0) > score(for: $1) }
    }

    mutating func clear() {
        scores.removeAll()
    }
}
