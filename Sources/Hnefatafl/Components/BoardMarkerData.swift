enum MarkerShape: String, CaseIterable, Equatable {
    case circle
    case square
    case arrow
    case dot
}

struct BoardMarkerData: Equatable {
    let row: Int
    let col: Int
    let shape: MarkerShape
    let color: String
}
