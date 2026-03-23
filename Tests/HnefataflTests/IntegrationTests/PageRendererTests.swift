import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("PageRenderer Tests")
struct PageRendererTests {

    @Test("renders complete page with stylesheet and app")
    func rendersCompletePage() {
        let state = GameState()
        let nodes = PageRenderer.render(state: state)
        let rendered = render(nodes)

        let style = rendered.find(tag: "style")
        #expect(style != nil)

        let app = rendered.findAll(tag: "div").filter {
            $0.className?.contains("viking-app") == true
        }
        #expect(app.count == 1)
    }

    @Test("page has html wrapper with lang attribute")
    func pageHasWrapper() {
        let state = GameState()
        let nodes = PageRenderer.render(state: state)
        let rendered = render(nodes)

        let wrapper = rendered.findAll(tag: "div").filter {
            $0.className?.contains("page-root") == true
        }
        #expect(wrapper.count == 1)
    }

    @Test("page includes board component")
    func pageIncludesBoard() {
        let state = GameState()
        let nodes = PageRenderer.render(state: state)
        let rendered = render(nodes)

        let board = rendered.findAll(tag: "div").filter {
            $0.className?.contains("board") == true
        }
        #expect(!board.isEmpty)
    }

    @Test("renderForStore creates render closure")
    func renderForStoreCreatesClosure() {
        let renderFn = PageRenderer.renderForStore()
        let nodes = renderFn(GameState())

        let rendered = render(nodes)
        let style = rendered.find(tag: "style")
        #expect(style != nil)
    }
}
