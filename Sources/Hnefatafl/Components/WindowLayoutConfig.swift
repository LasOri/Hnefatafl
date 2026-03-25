struct WindowLayoutConfig: Equatable {
    let width: Int
    let height: Int
    let isFullscreen: Bool
    let scale: Double

    var effectiveWidth: Int {
        Int(Double(width) * scale)
    }

    var effectiveHeight: Int {
        Int(Double(height) * scale)
    }

    static let defaultLayout = WindowLayoutConfig(
        width: 1024,
        height: 768,
        isFullscreen: false,
        scale: 1.0
    )
}
