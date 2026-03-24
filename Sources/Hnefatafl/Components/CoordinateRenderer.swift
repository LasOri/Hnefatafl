struct CoordinateRenderer {
    static func columnLabels(flipped: Bool = false) -> [String] {
        let labels = (0..<11).map { String(UnicodeScalar(65 + $0)!) }
        return flipped ? labels.reversed() : labels
    }

    static func rowLabels(flipped: Bool = false) -> [String] {
        let labels = (1...11).map { String($0) }
        return flipped ? labels.reversed() : labels
    }
}
