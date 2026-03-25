struct KillerMoveTable {
    static let maxDepth = 64

    private var slots: [[Move]]

    init() {
        slots = Array(repeating: [], count: Self.maxDepth)
    }

    mutating func store(move: Move, at depth: Int) {
        guard depth < Self.maxDepth else { return }
        if slots[depth].contains(move) { return }
        slots[depth].insert(move, at: 0)
        if slots[depth].count > 2 {
            slots[depth].removeLast()
        }
    }

    func killers(at depth: Int) -> [Move] {
        guard depth < Self.maxDepth else { return [] }
        return slots[depth]
    }

    func isKiller(move: Move, at depth: Int) -> Bool {
        killers(at: depth).contains(move)
    }

    mutating func clear() {
        slots = Array(repeating: [], count: Self.maxDepth)
    }
}
