import Testing
@testable import Hnefatafl

@Suite("About Info Tests")
struct AboutInfoTests {

    @Test("app name is Hnefatafl")
    func appName() {
        #expect(AboutInfo.data.appName == "Hnefatafl")
    }

    @Test("version is 1.0.0")
    func version() {
        #expect(AboutInfo.data.version == "1.0.0")
    }

    @Test("description is non-empty")
    func descriptionNonEmpty() {
        #expect(!AboutInfo.data.description.isEmpty)
    }

    @Test("AboutData supports equality")
    func aboutDataEquality() {
        let a = AboutData(appName: "X", version: "1", description: "D")
        let b = AboutData(appName: "X", version: "1", description: "D")
        #expect(a == b)
    }

    @Test("description mentions Viking")
    func descriptionMentionsViking() {
        #expect(AboutInfo.data.description.contains("Viking"))
    }
}
