struct BoardZoom: Equatable {
    static let minScale = 0.5
    static let maxScale = 3.0
    static let step = 0.25

    let scale: Double
    let offsetX: Double
    let offsetY: Double

    init(scale: Double = 1.0, offsetX: Double = 0, offsetY: Double = 0) {
        self.scale = scale
        self.offsetX = offsetX
        self.offsetY = offsetY
    }

    func zoomIn() -> BoardZoom {
        BoardZoom(scale: min(scale + Self.step, Self.maxScale), offsetX: offsetX, offsetY: offsetY)
    }

    func zoomOut() -> BoardZoom {
        BoardZoom(scale: max(scale - Self.step, Self.minScale), offsetX: offsetX, offsetY: offsetY)
    }

    func reset() -> BoardZoom {
        BoardZoom()
    }

    func pan(dx: Double, dy: Double) -> BoardZoom {
        BoardZoom(scale: scale, offsetX: offsetX + dx, offsetY: offsetY + dy)
    }

    var cssTransform: String {
        "scale(\(scale)) translate(\(offsetX)px, \(offsetY)px)"
    }
}
