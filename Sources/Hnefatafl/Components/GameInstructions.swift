struct InstructionPage: Equatable {
    let pageNumber: Int
    let title: String
    let body: String
}

enum GameInstructions {
    static let pages: [InstructionPage] = [
        InstructionPage(pageNumber: 1, title: "Welcome", body: "Hnefatafl is a Viking board game"),
        InstructionPage(pageNumber: 2, title: "Attackers", body: "Surround the king to win"),
        InstructionPage(pageNumber: 3, title: "Defenders", body: "Move the king to a corner to win"),
    ]

    static var pageCount: Int { pages.count }
}
