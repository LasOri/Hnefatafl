enum FeedbackType: String, Equatable {
    case info
    case success
    case warning
    case error
}

struct FeedbackMessage: Equatable {
    let text: String
    let type: FeedbackType
    let autoDismiss: Bool
}
