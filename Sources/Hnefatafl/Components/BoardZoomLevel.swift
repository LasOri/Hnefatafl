struct ZoomLevel: Equatable {
    let scale: Double
    let label: String

    static let normal = ZoomLevel(scale: 1.0, label: "100%")
    static let large = ZoomLevel(scale: 1.25, label: "125%")
    static let extraLarge = ZoomLevel(scale: 1.5, label: "150%")
}

enum BoardZoomControl {
    static let levels: [ZoomLevel] = [.normal, .large, .extraLarge]

    static func next(after current: ZoomLevel) -> ZoomLevel {
        guard let idx = levels.firstIndex(of: current) else { return .normal }
        return levels[(idx + 1) % levels.count]
    }

    static func cssTransform(for level: ZoomLevel) -> String {
        "transform: scale(\(level.scale))"
    }
}
