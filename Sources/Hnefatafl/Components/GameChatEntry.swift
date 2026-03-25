struct GameChatEntry: Equatable {
    let sender: String
    let message: String
    let moveNumber: Int

    var formattedEntry: String {
        "[\(moveNumber)] \(sender): \(message)"
    }
}
