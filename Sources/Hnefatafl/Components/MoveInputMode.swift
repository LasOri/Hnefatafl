enum MoveInputType: String, CaseIterable, Equatable {
    case click
    case drag
    case keyboard
}

struct MoveInputMode: Equatable {
    let inputType: MoveInputType
    let confirmRequired: Bool
}
