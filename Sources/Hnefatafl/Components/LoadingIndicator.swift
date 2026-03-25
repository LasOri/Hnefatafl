struct LoadingState: Equatable {
    let isLoading: Bool
    let message: String
    let progress: Double?
}

enum LoadingIndicator {
    static func thinking() -> LoadingState {
        LoadingState(isLoading: true, message: "AI thinking...", progress: nil)
    }

    static func loading() -> LoadingState {
        LoadingState(isLoading: true, message: "Loading...", progress: nil)
    }

    static func progress(_ value: Double) -> LoadingState {
        LoadingState(isLoading: true, message: "Loading...", progress: value)
    }

    static func done() -> LoadingState {
        LoadingState(isLoading: false, message: "", progress: nil)
    }
}
