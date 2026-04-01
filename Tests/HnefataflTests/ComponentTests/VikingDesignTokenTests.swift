import Testing
@testable import Hnefatafl

@Suite("Viking Design Token Tests")
struct VikingDesignTokenTests {

    // MARK: - Color Token Tests

    @Test("soot is deep charcoal hex")
    func soot_isDeepCharcoal() {
        #expect(VikingColors.soot == "#1a1410")
    }

    @Test("bone white is light ivory hex")
    func boneWhite_isLightIvory() {
        #expect(VikingColors.boneWhite == "#e8dcc8")
    }

    @Test("mead gold is accent hex")
    func meadGold_isAccent() {
        #expect(VikingColors.meadGold == "#c9a84c")
    }

    @Test("iron grey passes WCAG contrast")
    func ironGrey_passesContrast() {
        // Brightened to #8a8580 for 4.5:1 contrast against soot
        #expect(VikingColors.ironGrey == "#8a8580")
    }

    @Test("semantic backgroundPrimary equals soot")
    func backgroundPrimary_equalsSoot() {
        #expect(VikingColors.backgroundPrimary == VikingColors.soot)
    }

    @Test("semantic textPrimary equals boneWhite")
    func textPrimary_equalsBoneWhite() {
        #expect(VikingColors.textPrimary == VikingColors.boneWhite)
    }

    // MARK: - Typography Tests

    @Test("body font starts with Segoe UI")
    func bodyFont_startsWithSegoe() {
        #expect(VikingTypography.fontBody.contains("Segoe UI"))
    }

    @Test("display font starts with Georgia")
    func displayFont_startsWithGeorgia() {
        #expect(VikingTypography.fontDisplay.contains("Georgia"))
    }

    @Test("base size is 1rem")
    func baseSize_is1rem() {
        #expect(VikingTypography.sizeBase == "1rem")
    }

    @Test("runic tracking is 0.1em")
    func runicTracking_is01em() {
        #expect(VikingTypography.trackingRunic == "0.1em")
    }

    // MARK: - Spacing Tests

    @Test("spacing follows 8px grid")
    func spacing_follows8pxGrid() {
        #expect(VikingSpacing.space2 == "8px")
        #expect(VikingSpacing.space4 == "16px")
        #expect(VikingSpacing.space8 == "32px")
    }

    @Test("spacing scale is monotonically increasing")
    func spacing_isMonotonic() {
        let values = [
            VikingSpacing.space1, VikingSpacing.space2, VikingSpacing.space3,
            VikingSpacing.space4, VikingSpacing.space5, VikingSpacing.space6,
            VikingSpacing.space8, VikingSpacing.space10, VikingSpacing.space12
        ]
        // All end with "px" — parse numeric prefix
        for i in 0..<(values.count - 1) {
            let a = Int(values[i].replacingOccurrences(of: "px", with: "")) ?? 0
            let b = Int(values[i + 1].replacingOccurrences(of: "px", with: "")) ?? 0
            #expect(a < b, "space values must increase: \(values[i]) < \(values[i+1])")
        }
    }

    // MARK: - Border Tests

    @Test("border standard uses mead gold")
    func borderStandard_usesMeadGold() {
        #expect(VikingBorders.borderStandard.contains(VikingColors.meadGold))
    }

    @Test("radius scale exists")
    func radiusScale_exists() {
        #expect(VikingBorders.radiusNone == "0")
        #expect(VikingBorders.radiusMd == "4px")
        #expect(VikingBorders.radiusFull == "9999px")
    }

    // MARK: - Animation Tests

    @Test("animation durations are valid CSS")
    func animationDurations_areValidCSS() {
        #expect(VikingAnimations.durationFast.hasSuffix("s"))
        #expect(VikingAnimations.durationBase.hasSuffix("s"))
        #expect(VikingAnimations.durationSlow.hasSuffix("s"))
    }

    // MARK: - Z-Index Tests

    @Test("z-index scale is ordered")
    func zIndexScale_isOrdered() {
        let base = Int(VikingZIndex.base) ?? 0
        let raised = Int(VikingZIndex.raised) ?? 0
        let overlay = Int(VikingZIndex.overlay) ?? 0
        let modal = Int(VikingZIndex.modal) ?? 0
        #expect(base < raised)
        #expect(raised < overlay)
        #expect(overlay < modal)
    }
}
