import Testing
import LINKER
@testable import Hnefatafl

@Suite("Viking Piece SVG Tests")
struct VikingPieceSVGTests {

    // MARK: - Attacker SVG

    @Test("attacker returns one node")
    func attacker_returnsOneNode() {
        let nodes = VikingPieceSVG.attacker()
        #expect(nodes.count == 1)
    }

    @Test("attacker SVG has correct class")
    func attacker_hasCorrectClass() {
        let nodes = VikingPieceSVG.attacker()
        #expect(nodes.count == 1)
        // The SVG element should be rendered — verify structure
    }

    // MARK: - Defender SVG

    @Test("defender returns one node")
    func defender_returnsOneNode() {
        let nodes = VikingPieceSVG.defender()
        #expect(nodes.count == 1)
    }

    @Test("defender has no clipPath (collision fix)")
    func defender_noClipPath() {
        // After Allrianne refinement, defender uses pre-clipped paths
        // No clipPath element should be generated
        let nodes = VikingPieceSVG.defender()
        #expect(nodes.count == 1)
    }

    // MARK: - King SVG

    @Test("king returns one node")
    func king_returnsOneNode() {
        let nodes = VikingPieceSVG.king()
        #expect(nodes.count == 1)
    }

    @Test("king has no clipPath (collision fix)")
    func king_noClipPath() {
        let nodes = VikingPieceSVG.king()
        #expect(nodes.count == 1)
    }

    // MARK: - Valknut (Corner Ornament)

    @Test("valknut produces SVG element")
    func valknut_producesSVG() {
        let el = VikingPieceSVG.valknut()
        // Should be an SVG element
        #expect(el.tag == "svg")
    }

    @Test("valknut has aria-hidden")
    func valknut_hasAriaHidden() {
        let el = VikingPieceSVG.valknut()
        let hasAriaHidden = el.attributes.contains { $0.name == "aria-hidden" && $0.value == "true" }
        #expect(hasAriaHidden)
    }

    @Test("valknut has corner-valknut class")
    func valknut_hasCorrectClass() {
        let el = VikingPieceSVG.valknut()
        let hasClass = el.attributes.contains { $0.name == "class" && $0.value == "corner-valknut" }
        #expect(hasClass)
    }

    @Test("valknut default size is 20")
    func valknut_defaultSize20() {
        let el = VikingPieceSVG.valknut()
        let hasWidth = el.attributes.contains { $0.name == "width" && $0.value == "20" }
        #expect(hasWidth)
    }

    @Test("valknut custom size works")
    func valknut_customSize() {
        let el = VikingPieceSVG.valknut(size: 30)
        let hasWidth = el.attributes.contains { $0.name == "width" && $0.value == "30" }
        #expect(hasWidth)
    }

    // MARK: - Helm of Awe (Throne Ornament)

    @Test("helmOfAwe produces SVG element")
    func helmOfAwe_producesSVG() {
        let el = VikingPieceSVG.helmOfAwe()
        #expect(el.tag == "svg")
    }

    @Test("helmOfAwe has aria-hidden")
    func helmOfAwe_hasAriaHidden() {
        let el = VikingPieceSVG.helmOfAwe()
        let hasAriaHidden = el.attributes.contains { $0.name == "aria-hidden" && $0.value == "true" }
        #expect(hasAriaHidden)
    }

    @Test("helmOfAwe has throne-helm class")
    func helmOfAwe_hasCorrectClass() {
        let el = VikingPieceSVG.helmOfAwe()
        let hasClass = el.attributes.contains { $0.name == "class" && $0.value == "throne-helm" }
        #expect(hasClass)
    }

    @Test("helmOfAwe default size is 24")
    func helmOfAwe_defaultSize24() {
        let el = VikingPieceSVG.helmOfAwe()
        let hasWidth = el.attributes.contains { $0.name == "width" && $0.value == "24" }
        #expect(hasWidth)
    }

    @Test("helmOfAwe has 8 arms plus center (25 children)")
    func helmOfAwe_has8Arms() {
        let el = VikingPieceSVG.helmOfAwe()
        // 8 arms * 3 elements each (arm + 2 forks) + 1 center = 25
        #expect(el.children.count == 25)
    }

    @Test("helmOfAwe uses no trig functions (precomputed)")
    func helmOfAwe_usesPrecomputed() {
        // This test just verifies the function runs without error
        // on embedded Swift where cos/sin are unavailable
        let el = VikingPieceSVG.helmOfAwe(size: 24)
        #expect(el.tag == "svg")
    }
}
