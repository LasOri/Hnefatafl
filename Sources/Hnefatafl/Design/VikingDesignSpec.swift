// MARK: - Viking Design Specification
// Tindwyl (Design Architect) — Component Specification Document
//
// This file serves as the authoritative design spec for the Hnefatafl Viking UI.
// All component implementations must conform to these specifications.
//
// Archaeological Sources:
// - Gokstad Ship Burial (c. 900 CE) — shield forms, wood construction
// - Oseberg Ship (c. 834 CE) — carved ornament, Baroque animal style
// - Mammen Axe (c. 970 CE) — silver-inlaid iron, Mammen style art
// - Jelling Stones (c. 965 CE) — rune inscriptions, painted stone
// - Urnes Stave Church (c. 1130 CE) — ribbon knotwork, dragon motifs
// - Lewis Chessmen (c. 1150 CE) — piece form inspiration
// - Stora Hammars Stone (c. 700-800 CE) — Valknut symbol
// - Galdrabók (c. 1600, older origins) — Ægishjálmur stave

import LINKER

// MARK: - Component Specifications

/// Design spec for each component in the Viking UI system.
/// Atomic Design levels: Atom → Molecule → Organism → Template → Page
enum VikingDesignSpec {

    // ================================================
    // ATOMS — Smallest indivisible UI elements
    // ================================================

    /// Square (Atom)
    /// A single board cell — aged wood tile appearance
    /// States: default, hover, selected, legalMove, focused, corner, throne
    /// Accessibility: role=gridcell, aria-label with coordinate + piece
    /// Touch target: min 44x44px (WCAG 2.5.8)
    case square

    /// Piece SVG (Atom)
    /// Archaeological SVG piece — Gokstad shield (attacker), linden shield (defender), crowned shield (king)
    /// States: default, hover, dragging, capturing, captured
    /// Accessibility: role=img inside gridcell, piece description in parent aria-label
    /// Size: 85% of square, drop-shadow for depth
    case piece

    /// Button (Atom)
    /// Iron-banded control button
    /// States: default, hover, active, focused, disabled
    /// Accessibility: focus-visible outline, min 44px touch target on mobile
    case button

    /// Coordinate Label (Atom)
    /// Monospace coordinate text (A-K, 1-11)
    /// Muted color, runic letter-spacing
    case coordinateLabel

    /// Status Dot (Atom)
    /// 8px connection indicator dot
    /// States: connected (verdigris), connecting (gold pulse), disconnected (iron), failed (madder)
    case statusDot

    // ================================================
    // MOLECULES — Combinations of atoms
    // ================================================

    /// Board Row (Molecule)
    /// Contains: coord label + 11 squares with pieces
    /// CSS: display: contents (collapses into grid)
    case boardRow

    /// Capture Count Badge (Molecule)
    /// Contains: count number in iron-frame badge
    /// Monospace font, subtle gold background
    case captureCountBadge

    /// Move Item (Molecule)
    /// Contains: move number + algebraic notation
    /// Monospace font, hover highlight
    case moveItem

    /// P2P Input Group (Molecule)
    /// Contains: label + text input + action button
    /// Input: iron border, gold focus glow
    case p2pInputGroup

    // ================================================
    // ORGANISMS — Complex UI sections
    // ================================================

    /// Board (Organism)
    /// Contains: coordinate row + 11 board rows + overlay layer (trails, captures)
    /// Frame: gold-aged border, inset shadow, knotwork corner accents
    /// Max 550px wide, 1:1 aspect ratio
    /// Accessibility: role=grid, aria-label
    case board

    /// Status Bar (Organism)
    /// Contains: turn text (display font) + capture counts
    /// Iron-frame band, full width
    /// Accessibility: aria-live=polite for turn changes
    case statusBar

    /// Toolbar (Organism)
    /// Contains: 9 action buttons (undo, new game, AI toggle, mute, difficulty, personality, variant, flip, rules)
    /// Flex wrap, centered, gap-based spacing
    /// Accessibility: role=toolbar, aria-label
    case toolbar

    /// Move History Panel (Organism)
    /// Contains: scrollable list of move items
    /// Parchment-tinted scroll area, thin gold scrollbar
    /// Max 180px height, auto-scroll to latest move
    case moveHistoryPanel

    /// P2P Connect Panel (Organism)
    /// Contains: host panel OR join panel with input, status indicators
    /// Shield-card layout: host=gold/defender, join=woad/attacker
    case p2pConnectPanel

    /// Game Over Overlay (Organism)
    /// Contains: dramatic heading with rune-glow animation
    /// Full-screen radial gradient backdrop, blur
    /// Text: display font, uppercase, gold, 0.1em tracking
    /// Accessibility: role=alert, aria-live=assertive
    case gameOverOverlay

    /// Rules Panel (Organism)
    /// Contains: title + 5 rule sections with headings
    /// Parchment scroll appearance — warm gradient background
    /// Gold-aged border frame
    /// Close button at bottom
    case rulesPanel

    // ================================================
    // TEMPLATES — Page layouts
    // ================================================

    /// Game Template
    /// Vertical stack: Status → Board → Toolbar → EvalBar → MoveHistory
    /// Optional: P2P status panel above board when in P2P mode
    /// Optional: Game Over overlay on top
    /// Optional: Rules overlay on top
    case gameTemplate

    /// P2P Template
    /// Vertical stack: Title → Host Panel → Divider → Join Panel
    /// Shown before game starts in P2P mode
    case p2pTemplate

    // ================================================
    // PAGES
    // ================================================

    /// Main Game Page
    /// Container: .viking-app — dark gradient background
    /// Contains: style tag + game template OR p2p template
    /// Min-height: 100vh, centered flex column
    case mainGamePage
}

// MARK: - Design Validation Rules

/// Rules that must be satisfied for the design to be considered complete.
struct VikingDesignRules {
    /// Every interactive element must have min 44x44px touch target (WCAG 2.5.8)
    static let minTouchTarget = 44

    /// Text contrast ratios (WCAG AA)
    /// Normal text: 4.5:1 minimum
    /// Large text (>= 18pt or >= 14pt bold): 3:1 minimum
    /// UI components: 3:1 minimum
    static let contrastNormalText = 4.5
    static let contrastLargeText = 3.0
    static let contrastUI = 3.0

    /// All interactive elements must have focus-visible styles
    /// All status changes must have aria-live regions
    /// All images must have alt text or aria-hidden
    /// All form inputs must have associated labels
    static let accessibilityChecklist = [
        "Focus-visible on all interactive elements",
        "aria-live regions for dynamic content (turn changes, game over, P2P status)",
        "aria-label on all buttons and inputs",
        "role=grid on board, role=gridcell on squares",
        "role=toolbar on toolbar, role=dialog on overlays",
        "Keyboard navigation: arrow keys on board, tab between sections",
        "prefers-reduced-motion respected",
        "prefers-contrast: more supported",
        "prefers-color-scheme: dark supported"
    ]

    /// Responsive breakpoints
    /// Mobile: <= 600px — full-width board, larger buttons
    /// Tablet: 601-1024px — standard layout
    /// Desktop: > 1024px — standard layout, optional sidebar
    static let breakpoints = [600, 768, 1024, 1280]

    /// Animation budget: all animations complete within 300ms except
    /// game-over glow (continuous) and P2P pulse (continuous)
    static let maxAnimationDuration = 300 // ms
}
