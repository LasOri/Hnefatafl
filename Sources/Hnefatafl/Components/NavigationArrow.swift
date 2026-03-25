enum ArrowDirection: String, CaseIterable, Equatable {
    case up, down, left, right
}

struct NavigationArrow: Equatable {
    let direction: ArrowDirection
    let isEnabled: Bool
    let label: String

    static func forReplay(canBack: Bool, canForward: Bool) -> [NavigationArrow] {
        [
            NavigationArrow(direction: .left, isEnabled: canBack, label: "Previous move"),
            NavigationArrow(direction: .right, isEnabled: canForward, label: "Next move"),
        ]
    }
}
