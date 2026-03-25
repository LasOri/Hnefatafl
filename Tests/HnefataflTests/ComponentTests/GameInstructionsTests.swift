import Testing
@testable import Hnefatafl

@Suite("Game Instructions Tests")
struct GameInstructionsTests {

    @Test("page count is three")
    func pageCountIsThree() {
        #expect(GameInstructions.pageCount == 3)
    }

    @Test("first page is Welcome")
    func firstPageWelcome() {
        #expect(GameInstructions.pages[0].title == "Welcome")
    }

    @Test("pages have sequential numbers")
    func sequentialNumbers() {
        for (i, page) in GameInstructions.pages.enumerated() {
            #expect(page.pageNumber == i + 1)
        }
    }

    @Test("all pages have non-empty body")
    func nonEmptyBody() {
        for page in GameInstructions.pages {
            #expect(!page.body.isEmpty)
        }
    }

    @Test("InstructionPage supports equality")
    func instructionPageEquality() {
        let a = InstructionPage(pageNumber: 1, title: "A", body: "B")
        let b = InstructionPage(pageNumber: 1, title: "A", body: "B")
        #expect(a == b)
    }
}
