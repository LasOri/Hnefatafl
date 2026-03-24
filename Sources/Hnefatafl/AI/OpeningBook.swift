struct Opening: Equatable {
    let name: String
    let moves: [Move]
}

struct OpeningBook {
    static let allOpenings: [Opening] = [
        Opening(name: "Diamond Attack", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5),
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),
        ]),
        Opening(name: "Flank Rush", moves: [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),
            Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 2),
        ]),
        Opening(name: "Central Press", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 3, toCol: 5),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
        ]),
        Opening(name: "Corner Guard", moves: [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 1),
            Move(fromRow: 4, fromCol: 4, toRow: 2, toCol: 4),
        ]),
        Opening(name: "Pincer Opening", moves: [
            Move(fromRow: 0, fromCol: 7, toRow: 2, toCol: 7),
            Move(fromRow: 5, fromCol: 7, toRow: 2, toCol: 7),
        ]),
    ]

    static func detect(moves: [Move]) -> String? {
        guard !moves.isEmpty else { return nil }
        return allOpenings.first(where: { $0.moves == moves })?.name
    }

    static func detectPartial(moves: [Move]) -> [String] {
        guard !moves.isEmpty else { return [] }
        return allOpenings.filter { opening in
            guard opening.moves.count >= moves.count else { return false }
            return Array(opening.moves.prefix(moves.count)) == moves
        }.map(\.name)
    }
}
