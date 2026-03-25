import Testing
@testable import Hnefatafl

@Suite("Help Overlay Tests")
struct HelpOverlayTests {

    @Test("has topics")
    func hasTopics() {
        #expect(!HelpOverlay.topics.isEmpty)
    }

    @Test("count is 4")
    func countIsFour() {
        #expect(HelpOverlay.count == 4)
    }

    @Test("each topic has a title")
    func eachHasTitle() {
        for topic in HelpOverlay.topics {
            #expect(!topic.title.isEmpty)
        }
    }

    @Test("each topic has content")
    func eachHasContent() {
        for topic in HelpOverlay.topics {
            #expect(!topic.content.isEmpty)
        }
    }

    @Test("topics are unique")
    func topicsAreUnique() {
        let titles = HelpOverlay.topics.map { $0.title }
        let unique = Set(titles)
        #expect(unique.count == titles.count)
    }
}
