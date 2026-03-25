struct MoveFrequencyEntry: Equatable {
    let move: Move
    let count: Int
}

struct MoveFrequencyTracker: Equatable {
    private var frequencies: [MoveKey: Int] = [:]

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

        var move: Move {
            Move(fromRow: fromRow, fromCol: fromCol, toRow: toRow, toCol: toCol)
        }
    }

    var totalMoves: Int {
        frequencies.values.reduce(0, +)
    }

    var uniqueMoveCount: Int {
        frequencies.count
    }

    func frequency(of move: Move) -> Int {
        frequencies[MoveKey(move)] ?? 0
    }

    var mostFrequent: MoveFrequencyEntry? {
        guard let (key, count) = frequencies.max(by: { $0.value < $1.value }) else { return nil }
        return MoveFrequencyEntry(move: key.move, count: count)
    }

    func topMoves(count: Int) -> [MoveFrequencyEntry] {
        frequencies
            .sorted { $0.value > $1.value }
            .prefix(count)
            .map { MoveFrequencyEntry(move: $0.key.move, count: $0.value) }
    }

    mutating func record(move: Move) {
        let key = MoveKey(move)
        frequencies[key, default: 0] += 1
    }

    mutating func clear() {
        frequencies.removeAll()
    }
}
