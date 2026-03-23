import Testing
@testable import Hnefatafl
import LINKER
import LINKERTesting

@Suite("CSS Completeness Tests")
struct CSSCompletenessTests {

    @Test("CSS contains status-bar rule")
    func statusBarRule() {
        #expect(GameStyleSheet.css.contains(".status-bar"))
    }

    @Test("CSS contains status-turn rule")
    func statusTurnRule() {
        #expect(GameStyleSheet.css.contains(".status-turn"))
    }

    @Test("CSS contains status-in-progress rule")
    func statusInProgressRule() {
        #expect(GameStyleSheet.css.contains(".status-in-progress"))
    }

    @Test("CSS contains status-game-over rule")
    func statusGameOverRule() {
        #expect(GameStyleSheet.css.contains(".status-game-over"))
    }

    @Test("CSS contains status-captures rule")
    func statusCapturesRule() {
        #expect(GameStyleSheet.css.contains(".status-captures"))
    }

    @Test("CSS contains capture-count rule")
    func captureCountRule() {
        #expect(GameStyleSheet.css.contains(".capture-count"))
    }

    @Test("CSS contains square focus-visible rule")
    func squareFocusVisibleRule() {
        #expect(GameStyleSheet.css.contains(".square:focus-visible"))
    }

    @Test("CSS contains standalone legal-move rule")
    func legalMoveRule() {
        #expect(GameStyleSheet.css.contains(".legal-move"))
    }

    @Test("CSS contains btn focus-visible rule")
    func btnFocusVisibleRule() {
        #expect(GameStyleSheet.css.contains(".btn:focus-visible"))
    }

    @Test("CSS contains btn active rule")
    func btnActiveRule() {
        #expect(GameStyleSheet.css.contains(".btn:active"))
    }

    @Test("CSS contains piece-svg-attacker rule")
    func pieceSvgAttackerRule() {
        #expect(GameStyleSheet.css.contains(".piece-svg-attacker"))
    }
}
