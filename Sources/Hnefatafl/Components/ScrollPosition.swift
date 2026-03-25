struct ScrollPosition: Equatable {
    let offset: Int
    let visibleCount: Int
    let totalCount: Int

    var canScrollUp: Bool {
        offset > 0
    }

    var canScrollDown: Bool {
        offset + visibleCount < totalCount
    }

    var scrollPercentage: Double {
        guard totalCount > 0 else { return 0 }
        return Double(offset) / Double(totalCount)
    }
}
