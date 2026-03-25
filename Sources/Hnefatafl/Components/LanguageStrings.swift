enum Language: String, CaseIterable, Equatable {
    case english = "en"
    case norse = "no"
}

enum LanguageStrings {
    static func string(_ key: String, language: Language = .english) -> String {
        let strings: [Language: [String: String]] = [
            .english: [
                "title": "Hnefatafl",
                "new_game": "New Game",
                "undo": "Undo",
                "settings": "Settings"
            ],
            .norse: [
                "title": "Hnefatafl",
                "new_game": "Nytt Spill",
                "undo": "Angre",
                "settings": "Innstillinger"
            ]
        ]
        return strings[language]?[key] ?? key
    }
}
