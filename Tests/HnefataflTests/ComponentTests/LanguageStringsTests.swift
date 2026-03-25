import Testing
@testable import Hnefatafl

@Suite("LanguageStrings Tests")
struct LanguageStringsTests {

    @Test("english title")
    func englishTitle() {
        #expect(LanguageStrings.string("title", language: .english) == "Hnefatafl")
    }

    @Test("norse new game")
    func norseNewGame() {
        #expect(LanguageStrings.string("new_game", language: .norse) == "Nytt Spill")
    }

    @Test("unknown key returns key itself")
    func unknownKey() {
        #expect(LanguageStrings.string("nonexistent_key", language: .english) == "nonexistent_key")
    }

    @Test("default language is english")
    func defaultLanguage() {
        #expect(LanguageStrings.string("undo") == "Undo")
    }

    @Test("Language enum has two cases")
    func languageCases() {
        #expect(Language.allCases.count == 2)
    }
}
