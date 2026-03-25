struct PriorityItem: Equatable {
    let move: Move
    let priority: Int
}

struct MovePriorityQueue: Equatable {
    var items: [PriorityItem] = []

    var isEmpty: Bool { items.isEmpty }
    var count: Int { items.count }

    mutating func insert(move: Move, priority: Int) {
        items.append(PriorityItem(move: move, priority: priority))
    }

    mutating func dequeueMax() -> Move? {
        guard !items.isEmpty else { return nil }

        var maxIndex = 0
        var maxPriority = items[0].priority

        for (index, item) in items.enumerated() {
            if item.priority > maxPriority {
                maxPriority = item.priority
                maxIndex = index
            }
        }

        let move = items[maxIndex].move
        items.remove(at: maxIndex)
        return move
    }
}
