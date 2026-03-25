struct DragPreview: Equatable {
    let piece: Piece
    let x: Double
    let y: Double
    let opacity: Double

    var cssStyle: String {
        "position: absolute; left: \(x)px; top: \(y)px; opacity: \(opacity); pointer-events: none"
    }

    var isVisible: Bool {
        opacity > 0.0
    }
}
