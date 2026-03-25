struct Annotation: Equatable {
    let row: Int
    let col: Int
    let symbol: String
    let color: String
}

struct AnnotationLayer: Equatable {
    private(set) var annotations: [Annotation] = []

    mutating func add(_ annotation: Annotation) {
        annotations.append(annotation)
    }

    mutating func remove(at position: (Int, Int)) {
        annotations.removeAll { $0.row == position.0 && $0.col == position.1 }
    }

    mutating func clear() {
        annotations.removeAll()
    }
}
