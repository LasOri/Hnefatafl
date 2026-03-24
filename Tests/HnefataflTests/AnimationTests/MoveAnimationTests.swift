import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Move Animation Tests")
struct MoveAnimationTests {

    @Test("AnimationConfig maps move to gentle spring")
    func moveUsesGentleSpring() {
        let config = AnimationConfig.forMove
        #expect(config.spring == .gentle)
    }

    @Test("AnimationConfig maps capture to stiff spring")
    func captureUsesStiffSpring() {
        let config = AnimationConfig.forCapture
        #expect(config.spring == .stiff)
    }

    @Test("AnimationConfig duration derived from spring settling time")
    func durationFromSpring() {
        let config = AnimationConfig.forMove
        #expect(config.durationMs > 0)
        #expect(config.durationMs <= 600)
    }

    @Test("AnimationConfig.forCapture has shorter duration than forMove")
    func captureFasterThanMove() {
        #expect(AnimationConfig.forCapture.durationMs <= AnimationConfig.forMove.durationMs)
    }

    @Test("CSS contains piece-move keyframes")
    func cssContainsPieceMoveKeyframes() {
        let css = GameStyleSheet.css
        #expect(css.contains("@keyframes piece-move"))
    }

    @Test("CSS contains move-trail fade-in")
    func cssContainsMoveTrailFadeIn() {
        let css = GameStyleSheet.css
        #expect(css.contains("@keyframes trail-fade"))
    }

    @Test("CSS applies piece-move animation to animating class")
    func cssAnimatesMovingPiece() {
        let css = GameStyleSheet.css
        #expect(css.contains(".animating"))
        #expect(css.contains("piece-move"))
    }

    @Test("CSS applies trail-fade to move-trail")
    func cssAnimatesMoveTrail() {
        let css = GameStyleSheet.css
        #expect(css.contains("trail-fade"))
    }
}
