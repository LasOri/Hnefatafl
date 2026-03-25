struct MoveCountLabel: Equatable {
    var current: Int
    var total: Int?

    var displayText: String {
        if let total = total {
            return "Move \(current) / \(total)"
        }
        return "Move \(current)"
    }

    var hasTotal: Bool {
        total != nil
    }
}
