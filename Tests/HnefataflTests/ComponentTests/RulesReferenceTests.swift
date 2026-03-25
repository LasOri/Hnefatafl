import Testing
@testable import Hnefatafl

@Suite("Rules Reference Tests")
struct RulesReferenceTests {

    @Test("has rules")
    func hasRules() {
        #expect(!RulesReference.rules.isEmpty)
    }

    @Test("count is five")
    func countIsFive() {
        #expect(RulesReference.count == 5)
    }

    @Test("each rule has a title")
    func eachHasTitle() {
        for rule in RulesReference.rules {
            #expect(!rule.title.isEmpty)
        }
    }

    @Test("each rule has a description")
    func eachHasDescription() {
        for rule in RulesReference.rules {
            #expect(!rule.description.isEmpty)
        }
    }

    @Test("movement rule exists")
    func movementRuleExists() {
        let found = RulesReference.rules.contains { $0.title == "Movement" }
        #expect(found)
    }
}
