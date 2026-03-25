struct HintDisplay: Equatable {
    let suggestedMove: Move?
    let hintText: String
    let isVisible: Bool

    var hasHint: Bool {
        suggestedMove != nil
    }
}
