// MARK: - Viking Design Token System
// Authentic Norse/Viking Age color palette derived from archaeological artifacts:
// - Oseberg ship burial (834 CE) — carved wood, textiles
// - Gokstad ship (900 CE) — shield boss iron/gold
// - Mammen style (950-1000 CE) — silver inlay, niello
// - Urnes stave church (1130 CE) — knotwork, dragon heads
// - Jelling stones (965 CE) — painted rune stones, pigments

import LINKER

// MARK: - Color Tokens

/// Authentic Viking color palette based on pigments available in the Viking Age:
/// Iron oxide reds, charcoal blacks, bone white, ochre gold, woad blue,
/// verdigris green, birch bark tan, ash grey
struct VikingColors {
    // === Primary Palette (from archaeological pigment analysis) ===

    /// Deep charcoal — soot/lampblack pigment used on rune stones
    static let soot = "#1a1410"
    /// Rich dark brown — aged oak heartwood (longship hulls)
    static let oakHeart = "#2d1b0e"
    /// Warm brown — birch bark tan
    static let birchBark = "#8b6c4a"
    /// Bone/ivory — whale bone carvings, antler
    static let boneWhite = "#e8dcc8"
    /// Parchment — calfskin vellum used for manuscripts
    static let vellum = "#f0e6d0"

    // === Accent Metals (from metalwork finds) ===

    /// Mead gold — gold foil (guldgubbar) found at Helgo, Lundeborg
    static let meadGold = "#c9a84c"
    /// Bright gold — polished gold arm rings
    static let brightGold = "#dab85c"
    /// Aged gold — tarnished bronze brooches
    static let agedGold = "#a08030"
    /// Iron grey — pattern-welded sword blades
    static let ironGrey = "#8a8580"
    /// Silver — hacksilver from hoards (Cuerdale, Spillings)
    static let hackSilver = "#b0a898"

    // === Earth Tones (natural dyes from Birka textile finds) ===

    /// Woad blue — indigo dye from Isatis tinctoria
    static let woadBlue = "#2a4a6b"
    /// Deep woad — darker variant for contrast
    static let deepWoad = "#1a2a3a"
    /// Madder red — root dye (Rubia tinctorum), high-status garments
    static let madderRed = "#8b3a2a"
    /// Iron oxide — ochre pigment on rune stones
    static let ironOxide = "#a04530"
    /// Verdigris — copper patina, decorative metalwork
    static let verdigris = "#4a7c59"
    /// Dark verdigris
    static let deepVerdigris = "#2d5a3a"

    // === Board Squares ===

    /// Light square — light ashwood
    static let ashLight = "#d4a76a"
    /// Dark square — dark walnut
    static let walnutDark = "#5c3a1e"
    /// Corner square — burnished gold
    static let cornerGold = "#8b6914"
    /// Throne square — royal gold
    static let throneGold = "#c9a84c"

    // === Semantic Tokens ===

    static let backgroundPrimary = soot
    static let backgroundSecondary = oakHeart
    static let backgroundBoard = walnutDark
    static let textPrimary = boneWhite
    static let textSecondary = hackSilver
    static let textMuted = "#a09a94"
    static let accentPrimary = meadGold
    static let accentSecondary = agedGold
    static let successColor = verdigris
    static let errorColor = madderRed
    static let warningColor = ironOxide
    static let infoColor = woadBlue
}

// MARK: - Typography Tokens

/// Typography inspired by Viking Age runic inscriptions and manuscript traditions.
/// Primary: system sans-serif (accessible, fast loading)
/// Display: serif with runic character for headings
struct VikingTypography {
    /// Body text — clean readable sans-serif
    static let fontBody = "'Segoe UI', system-ui, -apple-system, sans-serif"
    /// Display headings — serif with old-style numerals
    static let fontDisplay = "Georgia, 'Times New Roman', serif"
    /// Monospace — for move notation, coordinates
    static let fontMono = "'Cascadia Code', 'Fira Code', 'Courier New', monospace"

    // Modular scale (1.25 ratio, base 1rem = 16px)
    static let sizeXs = "0.75rem"    // 12px — coordinates, fine print
    static let sizeSm = "0.875rem"   // 14px — move notation, buttons
    static let sizeBase = "1rem"     // 16px — body text
    static let sizeMd = "1.125rem"   // 18px — status text
    static let sizeLg = "1.5rem"     // 24px — section headings
    static let sizeXl = "2rem"       // 32px — game over text
    static let sizeXxl = "2.5rem"    // 40px — hero display

    // Weights
    static let weightNormal = "400"
    static let weightMedium = "500"
    static let weightBold = "700"

    // Line heights
    static let lineHeightTight = "1.2"
    static let lineHeightBase = "1.5"
    static let lineHeightRelaxed = "1.75"

    // Letter spacing — slightly wider for headings (runic inscription style)
    static let trackingNormal = "0"
    static let trackingWide = "0.05em"
    static let trackingRunic = "0.1em"   // Mimics spaced rune carving
}

// MARK: - Spacing Tokens (8px grid)

struct VikingSpacing {
    static let space0 = "0"
    static let space1 = "4px"    // 0.5 unit
    static let space2 = "8px"    // 1 unit — minimum spacing
    static let space3 = "12px"   // 1.5 units
    static let space4 = "16px"   // 2 units — standard padding
    static let space5 = "20px"   // 2.5 units
    static let space6 = "24px"   // 3 units — section spacing
    static let space8 = "32px"   // 4 units — large gaps
    static let space10 = "40px"  // 5 units
    static let space12 = "48px"  // 6 units — page margins
    static let space16 = "64px"  // 8 units
}

// MARK: - Border & Shadow Tokens

/// Borders inspired by Viking Age metalwork: beaded edges, twisted wire,
/// and carved knotwork frames from Urnes/Ringerike style
struct VikingBorders {
    static let radiusNone = "0"
    static let radiusSm = "2px"       // Subtle rounding (carved wood)
    static let radiusMd = "4px"       // Standard
    static let radiusLg = "8px"       // Panel corners
    static let radiusFull = "9999px"  // Pill shape (shield boss)

    static let widthThin = "1px"
    static let widthMedium = "2px"
    static let widthThick = "3px"
    static let widthHeavy = "4px"

    // Border styles that evoke Viking metalwork
    static let borderSubtle = "1px solid rgba(201, 168, 76, 0.2)"
    static let borderStandard = "2px solid \(VikingColors.meadGold)"
    static let borderAccent = "2px solid \(VikingColors.brightGold)"
    static let borderThrone = "2px dashed \(VikingColors.meadGold)"
    static let borderCorner = "3px solid \(VikingColors.meadGold)"
    static let borderIron = "2px solid \(VikingColors.ironGrey)"
}

// MARK: - Shadow Tokens

struct VikingShadows {
    /// Subtle elevation — like a carved rune slightly raised
    static let shadowSm = "0 1px 3px rgba(0, 0, 0, 0.3)"
    /// Standard card elevation
    static let shadowMd = "0 4px 8px rgba(0, 0, 0, 0.4)"
    /// Deep shadow — floating panels
    static let shadowLg = "0 8px 24px rgba(0, 0, 0, 0.5)"
    /// Gold glow — selected/active elements (emulating firelight)
    static let glowGold = "0 0 12px 4px rgba(201, 168, 76, 0.4)"
    /// Strong gold glow — selected piece
    static let glowGoldStrong = "0 0 16px 6px rgba(201, 168, 76, 0.6)"
    /// Warm ember glow — capture effects
    static let glowEmber = "0 0 12px 4px rgba(160, 69, 48, 0.5)"
    /// Woad blue glow — P2P connection active
    static let glowWoad = "0 0 12px 4px rgba(42, 74, 107, 0.5)"
}

// MARK: - Animation Tokens

struct VikingAnimations {
    static let durationFast = "0.15s"
    static let durationBase = "0.3s"
    static let durationSlow = "0.5s"
    static let durationDramatic = "0.8s"

    static let easingDefault = "cubic-bezier(0.4, 0, 0.2, 1)"
    static let easingBounce = "cubic-bezier(0.34, 1.56, 0.64, 1)"
    static let easingSnap = "cubic-bezier(0, 0, 0.2, 1)"
}

// MARK: - Breakpoints

struct VikingBreakpoints {
    static let mobile = "600px"
    static let tablet = "768px"
    static let desktop = "1024px"
    static let wide = "1280px"
}

// MARK: - Z-Index Scale

struct VikingZIndex {
    static let base = "0"
    static let raised = "1"
    static let overlay = "10"
    static let modal = "100"
    static let toast = "200"
}
