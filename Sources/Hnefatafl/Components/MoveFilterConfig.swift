enum MoveFilterType: String, CaseIterable, Equatable {
    case all
    case captures
    case threats
    case retreats
}

struct MoveFilterConfig: Equatable {
    let filterType: MoveFilterType
    let sortByQuality: Bool

    static let defaultFilter = MoveFilterConfig(
        filterType: .all,
        sortByQuality: false
    )
}
