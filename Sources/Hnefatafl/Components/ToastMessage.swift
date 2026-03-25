struct ToastData: Equatable {
    let message: String
    let type: ToastType
    let durationMs: Int
}

enum ToastType: String, Equatable {
    case info
    case warning
    case error
    case success
}

enum ToastMessage {
    static func info(_ msg: String) -> ToastData {
        ToastData(message: msg, type: .info, durationMs: 3000)
    }

    static func warning(_ msg: String) -> ToastData {
        ToastData(message: msg, type: .warning, durationMs: 5000)
    }

    static func error(_ msg: String) -> ToastData {
        ToastData(message: msg, type: .error, durationMs: 7000)
    }

    static func success(_ msg: String) -> ToastData {
        ToastData(message: msg, type: .success, durationMs: 3000)
    }
}
