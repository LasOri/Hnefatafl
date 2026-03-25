struct OpeningMoveEntry: Equatable {
    let name: String
    let firstMove: Move
    let response: Move?
}

enum OpeningMoveDatabase {
    static let entries: [OpeningMoveEntry] = [
        OpeningMoveEntry(name: "Center Attack", firstMove: Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5), response: nil),
        OpeningMoveEntry(name: "Flank Attack", firstMove: Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3), response: nil),
        OpeningMoveEntry(name: "Edge Press", firstMove: Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 2), response: nil),
    ]

    static var count: Int { entries.count }

    static func find(name: String) -> OpeningMoveEntry? {
        entries.first { $0.name == name }
    }
}
