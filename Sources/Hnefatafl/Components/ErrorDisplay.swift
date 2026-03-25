struct ErrorInfo: Equatable {
    let code: String
    let message: String
    let isRecoverable: Bool
}

enum ErrorDisplay {
    static func fromValidation(_ error: String) -> ErrorInfo {
        ErrorInfo(code: "VALIDATION", message: error, isRecoverable: true)
    }

    static func fromSystem(_ error: String) -> ErrorInfo {
        ErrorInfo(code: "SYSTEM", message: error, isRecoverable: false)
    }

    static func fromNetwork(_ error: String) -> ErrorInfo {
        ErrorInfo(code: "NETWORK", message: error, isRecoverable: true)
    }
}
