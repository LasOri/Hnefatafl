struct IncrementConfig: Equatable {
    let secondsPerMove: Int

    var label: String {
        if secondsPerMove == 0 { return "No increment" }
        return "+\(secondsPerMove)s/move"
    }

    func apply(to seconds: Int) -> Int {
        guard secondsPerMove > 0 else { return seconds }
        let result = seconds.addingReportingOverflow(secondsPerMove)
        return result.overflow ? Int.max : result.partialValue
    }

    static let none = IncrementConfig(secondsPerMove: 0)
    static let fischer = IncrementConfig(secondsPerMove: 5)
    static let bronstein = IncrementConfig(secondsPerMove: 10)
}
