// MARK: - Viking Stylesheet
// Complete CSS overhaul with authentic Norse/Viking Age design language.
// Every visual element draws from real archaeological sources:
// - Color palette: Viking Age pigments (iron oxide, woad, ochre, charcoal)
// - Borders: Urnes-style knotwork patterns via CSS
// - Textures: Wood grain, parchment, hammered metal
// - Animations: Fire flicker, rune glow, shield clash
// - Typography: Runic-inspired letter spacing, serif display headings

import LINKER

struct VikingStyleSheet {
    static let css = """
    /* ==========================================
       VIKING DESIGN SYSTEM — HNEFATAFL
       Authentic Norse/Viking Age visual language
       ========================================== */

    /* --- CSS Custom Properties (Design Tokens) --- */
    :root {
        /* Primary palette — archaeological pigments */
        --viking-soot: #1a1410;
        --viking-oak: #2d1b0e;
        --viking-birch: #8b6c4a;
        --viking-bone: #e8dcc8;
        --viking-vellum: #f0e6d0;

        /* Metals */
        --viking-gold: #c9a84c;
        --viking-gold-bright: #dab85c;
        --viking-gold-aged: #a08030;
        --viking-iron: #8a8580;
        --viking-silver: #b0a898;

        /* Earth tones */
        --viking-woad: #2a4a6b;
        --viking-woad-deep: #1a2a3a;
        --viking-madder: #8b3a2a;
        --viking-oxide: #a04530;
        --viking-verdigris: #4a7c59;
        --viking-verdigris-deep: #2d5a3a;

        /* Board */
        --board-bg: #2d1b0e;
        --square-light: #d4a76a;
        --square-dark: #b8924e;
        --square-corner: #8b6914;
        --square-throne: #c9a84c;

        /* Semantic */
        --text-primary: #e8dcc8;
        --text-secondary: #b0a898;
        --text-muted: #a09a94;
        --accent: #c9a84c;
        --accent-hover: #dab85c;
        --glow-gold: rgba(201, 168, 76, 0.4);
        --glow-gold-strong: rgba(201, 168, 76, 0.6);
        --glow-ember: rgba(160, 69, 48, 0.5);

        /* Spacing (8px grid) */
        --space-1: 4px;
        --space-2: 8px;
        --space-3: 12px;
        --space-4: 16px;
        --space-6: 24px;
        --space-8: 32px;

        /* Typography */
        --font-body: 'Segoe UI', system-ui, -apple-system, sans-serif;
        --font-display: Georgia, 'Times New Roman', serif;
        --font-mono: 'Cascadia Code', 'Fira Code', 'Courier New', monospace;

        /* Shadows */
        --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.3);
        --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.4);
        --shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.5);

        /* Transitions */
        --duration-fast: 0.15s;
        --duration-base: 0.3s;
        --easing: cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* --- Global Reset & Base --- */
    * { box-sizing: border-box; margin: 0; padding: 0; }

    /* --- App Container: Dark aged wood background --- */
    .viking-app {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-family: var(--font-body);
        background:
            linear-gradient(180deg,
                var(--viking-soot) 0%,
                var(--viking-oak) 50%,
                var(--viking-soot) 100%);
        color: var(--text-primary);
        min-height: 100vh;
        padding: var(--space-6);
        gap: var(--space-4);
    }

    /* --- Board Container: Carved wood frame --- */
    .viking-theme {
        background: var(--board-bg);
        padding: var(--space-3);
        border-radius: 4px;
        border: 3px solid var(--viking-gold-aged);
        box-shadow:
            var(--shadow-lg),
            inset 0 0 20px rgba(0, 0, 0, 0.3),
            0 0 30px rgba(201, 168, 76, 0.1);
        position: relative;
    }

    /* Knotwork corner accents on board frame */
    .viking-theme::before,
    .viking-theme::after {
        content: '';
        position: absolute;
        width: 12px;
        height: 12px;
        border: 2px solid var(--viking-gold);
        border-radius: 50%;
        opacity: 0.6;
    }
    .viking-theme::before { top: -6px; left: -6px; }
    .viking-theme::after { top: -6px; right: -6px; }

    .board {
        display: grid;
        grid-template-columns: auto repeat(11, 1fr);
        grid-template-rows: auto repeat(11, 1fr);
        gap: 1px;
        max-width: 580px;
        width: 100%;
        touch-action: none;
        user-select: none;
        -webkit-user-select: none;
        background: rgba(0, 0, 0, 0.3);
        position: relative;
    }

    .board-row {
        display: contents;
    }

    /* --- Squares: Aged wood tiles --- */
    .square {
        aspect-ratio: 1;
        background: var(--square-light);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        position: relative;
        transition: background-color var(--duration-fast) var(--easing),
                    box-shadow var(--duration-fast) var(--easing);
        min-width: 0;
        min-height: 0;
    }

    .square:hover {
        filter: brightness(1.08);
    }

    /* Corner squares — sacred refuge, gold-rimmed */
    .square-corner {
        background: var(--square-corner);
        border: 2px solid var(--viking-gold);
        box-shadow: inset 0 0 8px rgba(201, 168, 76, 0.2);
    }

    /* Throne square — king's seat, dashed border */
    .square-throne {
        background: var(--square-throne);
        border: 2px dashed var(--viking-gold);
        box-shadow: inset 0 0 12px rgba(201, 168, 76, 0.15);
    }

    /* --- Pieces --- */
    .piece-attacker, .piece-defender, .piece-king {
        cursor: grab;
    }

    .piece-svg {
        width: 85%;
        height: 85%;
        filter: drop-shadow(0 2px 3px rgba(0, 0, 0, 0.4));
        transition: transform var(--duration-fast) var(--easing),
                    filter var(--duration-fast) var(--easing);
    }

    .piece-svg:hover {
        filter: drop-shadow(0 3px 5px rgba(0, 0, 0, 0.5));
    }

    .dragging {
        cursor: grabbing;
        opacity: 0.8;
        z-index: 10;
    }

    .dragging .piece-svg {
        transform: scale(1.1);
        filter: drop-shadow(0 6px 12px rgba(0, 0, 0, 0.6));
    }

    /* --- Selection & Interaction --- */
    .selected {
        outline: 2px solid var(--viking-gold-bright);
        outline-offset: -2px;
        z-index: 1;
    }

    .glow {
        box-shadow: 0 0 16px 6px var(--glow-gold);
        z-index: 1;
    }

    .selected.glow {
        box-shadow: var(--glow-gold-strong);
    }

    .legal-move {
        background: rgba(201, 168, 76, 0.25);
    }

    .move-indicator {
        background: rgba(201, 168, 76, 0.25);
    }

    .move-indicator::after {
        content: '';
        width: 28%;
        height: 28%;
        border-radius: 50%;
        background: var(--viking-gold);
        opacity: 0.6;
        position: absolute;
        box-shadow: 0 0 4px rgba(201, 168, 76, 0.4);
    }

    .focused {
        outline: 2px dashed #fff;
        outline-offset: -2px;
        z-index: 1;
    }

    /* --- Status Bar: Runic inscription band --- */
    .status-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        max-width: 550px;
        padding: var(--space-3) var(--space-4);
        background: rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(201, 168, 76, 0.2);
        border-radius: 4px;
    }

    .status-turn {
        font-family: var(--font-display);
        font-size: 1.125rem;
        font-weight: 600;
        letter-spacing: 0.05em;
    }

    .status-in-progress {
        color: var(--text-primary);
    }

    .status-game-over {
        color: var(--viking-gold-bright);
        font-size: 1.3rem;
        text-shadow: 0 0 10px rgba(201, 168, 76, 0.4);
    }

    .status-captures {
        display: flex;
        gap: var(--space-4);
        font-size: 0.875rem;
    }

    .capture-count {
        padding: var(--space-1) var(--space-2);
        background: rgba(201, 168, 76, 0.1);
        border: 1px solid rgba(201, 168, 76, 0.15);
        border-radius: 4px;
        font-family: var(--font-mono);
        letter-spacing: 0.05em;
    }

    /* --- Toolbar: Iron-banded button row --- */
    .toolbar {
        display: flex;
        gap: var(--space-2);
        padding: var(--space-2) 0;
        flex-wrap: wrap;
        justify-content: center;
        width: 100%;
        max-width: 550px;
    }

    .btn {
        padding: var(--space-2) var(--space-4);
        border: 1px solid var(--viking-gold-aged);
        background: rgba(45, 27, 14, 0.6);
        color: var(--text-primary);
        border-radius: 4px;
        cursor: pointer;
        font-family: var(--font-body);
        font-size: 0.875rem;
        letter-spacing: 0.03em;
        transition: all var(--duration-fast) var(--easing);
        position: relative;
        overflow: hidden;
    }

    .btn:hover {
        background: rgba(201, 168, 76, 0.15);
        border-color: var(--viking-gold);
        color: var(--viking-gold-bright);
    }

    .btn:active {
        background: rgba(201, 168, 76, 0.25);
        transform: translateY(1px);
    }

    .btn:focus-visible {
        outline: 2px solid #fff;
        outline-offset: 2px;
    }

    /* --- Move History: Scroll parchment --- */
    .move-history-panel {
        max-height: 180px;
        overflow-y: auto;
        width: 100%;
        max-width: 550px;
        padding: var(--space-3);
        background: rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(201, 168, 76, 0.15);
        border-radius: 4px;
        scrollbar-width: thin;
        scrollbar-color: var(--viking-gold-aged) transparent;
    }

    .move-history-panel::-webkit-scrollbar {
        width: 6px;
    }
    .move-history-panel::-webkit-scrollbar-track {
        background: transparent;
    }
    .move-history-panel::-webkit-scrollbar-thumb {
        background: var(--viking-gold-aged);
        border-radius: 3px;
    }

    .move-history {
        list-style: none;
        padding: 0;
        display: flex;
        flex-wrap: wrap;
        gap: var(--space-1);
        font-family: var(--font-mono);
        font-size: 0.75rem;
        color: var(--text-secondary);
    }

    .move-item {
        padding: var(--space-1) var(--space-2);
        background: rgba(201, 168, 76, 0.08);
        border-radius: 2px;
        transition: background var(--duration-fast);
        min-height: 24px;
        display: inline-flex;
        align-items: center;
    }

    .move-item:hover {
        background: rgba(201, 168, 76, 0.2);
        color: var(--text-primary);
    }

    /* --- Game Over: Dramatic Viking overlay --- */
    .game-over-overlay {
        position: fixed;
        inset: 0;
        background: radial-gradient(
            ellipse at center,
            rgba(45, 27, 14, 0.95) 0%,
            rgba(26, 20, 16, 0.98) 100%
        );
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        z-index: 100;
        backdrop-filter: blur(4px);
    }

    .game-over-text {
        font-family: var(--font-display);
        color: var(--viking-gold-bright);
        font-size: 2.5rem;
        font-weight: 700;
        text-align: center;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        text-shadow:
            0 0 20px rgba(201, 168, 76, 0.5),
            0 0 40px rgba(201, 168, 76, 0.2),
            0 2px 4px rgba(0, 0, 0, 0.8);
        animation: rune-glow 2s ease-in-out infinite alternate;
    }

    .btn-play-again {
        margin-top: var(--space-6);
        padding: var(--space-3) var(--space-8);
        background: rgba(201, 168, 76, 0.15);
        border: 2px solid var(--viking-gold);
        color: var(--viking-gold-bright);
        border-radius: 4px;
        cursor: pointer;
        font-family: var(--font-display);
        font-size: 1.25rem;
        letter-spacing: 0.08em;
        transition: all var(--duration-fast) var(--easing);
    }

    .btn-play-again:hover {
        background: rgba(201, 168, 76, 0.25);
        box-shadow: 0 0 20px rgba(201, 168, 76, 0.4);
    }

    .btn-play-again:focus-visible {
        outline: 2px solid #fff;
        outline-offset: 4px;
    }

    /* --- Rules Panel: Aged parchment scroll --- */
    .rules-overlay {
        position: fixed;
        inset: 0;
        background: rgba(26, 20, 16, 0.9);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        z-index: 100;
        padding: var(--space-6);
        backdrop-filter: blur(2px);
    }

    .rules-content {
        max-width: 600px;
        max-height: 80vh;
        overflow-y: auto;
        padding: var(--space-8);
        background:
            linear-gradient(135deg,
                #d4c5a0 0%,
                #e8dcc8 20%,
                #ddd0b8 50%,
                #e0d4bc 80%,
                #cfc2a0 100%);
        color: var(--viking-oak);
        border: 3px solid var(--viking-gold-aged);
        border-radius: 4px;
        box-shadow: var(--shadow-lg), 0 0 30px rgba(201, 168, 76, 0.15);
        scrollbar-width: thin;
    }

    .rules-title {
        font-family: var(--font-display);
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--viking-oak);
        text-align: center;
        letter-spacing: 0.1em;
        margin-bottom: var(--space-6);
        padding-bottom: var(--space-3);
        border-bottom: 2px solid var(--viking-gold-aged);
    }

    .rules-content h3 {
        font-family: var(--font-display);
        font-size: 1.125rem;
        color: var(--viking-madder);
        margin-top: var(--space-6);
        margin-bottom: var(--space-2);
        letter-spacing: 0.05em;
    }

    .rules-content p {
        font-size: 0.9375rem;
        line-height: 1.6;
        margin-bottom: var(--space-3);
        color: #3d2a14;
    }

    .btn-close-rules {
        margin-top: var(--space-4);
        padding: var(--space-2) var(--space-8);
        background: var(--viking-oak);
        color: var(--viking-bone);
        border: 2px solid var(--viking-gold-aged);
        border-radius: 4px;
        cursor: pointer;
        font-family: var(--font-display);
        font-size: 1rem;
        letter-spacing: 0.05em;
    }

    .btn-close-rules:hover {
        background: var(--viking-gold-aged);
        color: var(--viking-bone);
    }

    /* --- Coordinate Labels --- */
    .coord-label {
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: var(--font-mono);
        font-size: 0.7rem;
        color: var(--text-muted);
        user-select: none;
        letter-spacing: 0.05em;
        min-width: 20px;
        padding: 0 2px;
    }

    .coord-row {
        display: contents;
    }

    /* --- Ornament SVGs in special squares --- */
    .corner-valknut, .throne-helm {
        width: 50%;
        height: 50%;
        opacity: 0.6;
    }

    /* --- Move Trail Overlay --- */
    .move-trail {
        position: absolute;
        pointer-events: none;
        opacity: 0.5;
        animation: trail-fade 0.2s ease-in forwards;
        /* Positioned by grid placement to cover just the 11x11 square area */
        grid-column: 2 / -1;
        grid-row: 2 / -1;
        z-index: 5;
    }

    /* --- Capture Effect --- */
    .capture-effect {
        pointer-events: none;
        position: relative;
        z-index: 5;
    }

    .particle {
        position: absolute;
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background: var(--viking-gold);
        animation: particle-burst 0.5s ease-out forwards;
        top: 50%;
        left: 50%;
    }
    .particle-0 { --dx: -12px; --dy: -12px; }
    .particle-1 { --dx: 12px; --dy: -12px; }
    .particle-2 { --dx: -12px; --dy: 12px; }
    .particle-3 { --dx: 12px; --dy: 12px; }

    /* --- Eval Bar --- */
    .eval-bar {
        width: 100%;
        max-width: 550px;
        padding: var(--space-1) var(--space-3);
        background: rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(201, 168, 76, 0.15);
        border-radius: 4px;
        font-family: var(--font-mono);
        font-size: 0.75rem;
        color: var(--text-secondary);
        text-align: center;
    }

    /* --- Screen Reader Only --- */
    .sr-only {
        position: absolute;
        width: 1px;
        height: 1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        white-space: nowrap;
        border: 0;
    }

    /* --- P2P Connection Screen --- */
    .p2p-connect {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: var(--space-4);
        width: 100%;
        max-width: 400px;
        padding: var(--space-6);
    }

    .p2p-panel {
        width: 100%;
        padding: var(--space-6);
        background: rgba(0, 0, 0, 0.3);
        border: 2px solid rgba(201, 168, 76, 0.2);
        border-radius: 8px;
        box-shadow: var(--shadow-md);
    }

    .p2p-panel h3 {
        font-family: var(--font-display);
        font-size: 1.25rem;
        color: var(--viking-gold);
        margin-bottom: var(--space-4);
        text-align: center;
        letter-spacing: 0.08em;
    }

    .p2p-id {
        font-family: var(--font-mono);
        font-size: 0.75rem;
        padding: var(--space-3);
        background: rgba(0, 0, 0, 0.4);
        border: 1px solid var(--viking-iron);
        border-radius: 4px;
        color: var(--viking-gold);
        word-break: break-all;
        text-align: center;
        cursor: pointer;
        transition: border-color var(--duration-fast);
    }

    .p2p-id:hover {
        border-color: var(--viking-gold);
    }

    .p2p-input {
        width: 100%;
        padding: var(--space-3);
        background: rgba(0, 0, 0, 0.4);
        border: 1px solid var(--viking-iron);
        border-radius: 4px;
        color: var(--text-primary);
        font-family: var(--font-mono);
        font-size: 0.875rem;
        outline: 2px solid transparent;
        transition: border-color var(--duration-fast);
    }

    .p2p-input:focus-visible {
        border-color: var(--viking-gold);
        box-shadow: 0 0 8px rgba(201, 168, 76, 0.2);
        outline: 2px solid var(--viking-gold);
        outline-offset: 2px;
    }

    .p2p-input::placeholder {
        color: var(--text-secondary);
    }

    .p2p-status {
        display: flex;
        align-items: center;
        gap: var(--space-2);
        font-size: 0.875rem;
        padding: var(--space-2) 0;
    }

    .p2p-status-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        flex-shrink: 0;
    }

    .p2p-status-dot.connected { background: var(--viking-verdigris); box-shadow: 0 0 6px var(--viking-verdigris); }
    .p2p-status-dot.connecting { background: var(--viking-gold); animation: pulse 1.5s ease-in-out infinite; }
    .p2p-status-dot.disconnected { background: #a09a94; }
    .p2p-status-dot.failed { background: var(--viking-madder); }

    .btn-host, .btn-join {
        width: 100%;
        padding: var(--space-3) var(--space-4);
        font-family: var(--font-display);
        font-size: 1rem;
        letter-spacing: 0.05em;
        border-radius: 4px;
        cursor: pointer;
        transition: all var(--duration-fast) var(--easing);
    }

    .btn-host {
        background: rgba(201, 168, 76, 0.15);
        border: 2px solid var(--viking-gold);
        color: var(--viking-gold-bright);
    }

    .btn-host:hover {
        background: rgba(201, 168, 76, 0.25);
        box-shadow: 0 0 12px rgba(201, 168, 76, 0.3);
    }

    .btn-join {
        background: rgba(42, 74, 107, 0.2);
        border: 2px solid var(--viking-woad);
        color: var(--text-primary);
    }

    .btn-join:hover {
        background: rgba(42, 74, 107, 0.3);
        border-color: #3a6a9b;
    }

    .p2p-divider {
        text-align: center;
        color: var(--text-muted);
        font-family: var(--font-display);
        font-size: 0.875rem;
        letter-spacing: 0.1em;
        position: relative;
    }

    .p2p-divider::before,
    .p2p-divider::after {
        content: '';
        position: absolute;
        top: 50%;
        width: 35%;
        height: 1px;
        background: rgba(201, 168, 76, 0.2);
    }
    .p2p-divider::before { left: 0; }
    .p2p-divider::after { right: 0; }

    .p2p-title {
        font-family: var(--font-display);
        font-size: 1.5rem;
        color: var(--viking-gold);
        text-align: center;
        letter-spacing: 0.1em;
        margin-bottom: var(--space-4);
    }

    .p2p-role {
        font-family: var(--font-display);
        font-size: 1.125rem;
        letter-spacing: 0.05em;
    }

    .p2p-id-label {
        font-size: 0.75rem;
        color: var(--text-muted);
        margin-top: var(--space-3);
    }

    .p2p-leave-btn {
        margin-top: var(--space-4);
    }

    .p2p-desc {
        font-size: 0.875rem;
        color: var(--text-secondary);
        margin-bottom: var(--space-4);
    }

    .p2p-variant-label {
        font-size: 0.75rem;
        color: var(--text-muted);
        margin-bottom: var(--space-2);
    }

    .p2p-join-btn {
        margin-top: var(--space-3);
    }

    /* Skip navigation link */
    .skip-link:focus {
        position: static !important;
        width: auto !important;
        height: auto !important;
        overflow: visible !important;
        clip: auto !important;
        white-space: normal !important;
        padding: var(--space-2) var(--space-4);
        background: var(--viking-gold);
        color: var(--viking-soot);
        font-weight: 600;
        z-index: 1000;
    }

    /* --- Animations --- */
    @keyframes rune-glow {
        from {
            text-shadow:
                0 0 20px rgba(201, 168, 76, 0.5),
                0 0 40px rgba(201, 168, 76, 0.2),
                0 2px 4px rgba(0, 0, 0, 0.8);
        }
        to {
            text-shadow:
                0 0 30px rgba(201, 168, 76, 0.7),
                0 0 60px rgba(201, 168, 76, 0.3),
                0 2px 4px rgba(0, 0, 0, 0.8);
        }
    }

    @keyframes particle-burst {
        0% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
        100% { transform: translate(calc(-50% + var(--dx, 0px)), calc(-50% + var(--dy, 0px))) scale(0); opacity: 0; }
    }

    @keyframes trail-fade {
        from { opacity: 0; }
        to { opacity: 0.5; }
    }

    @keyframes piece-move {
        from { transform: translate(var(--move-dx), var(--move-dy)); }
        to { transform: translate(0, 0); }
    }

    .animating {
        animation: piece-move 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
    }

    @keyframes capture-burst {
        0% { transform: scale(0); opacity: 1; }
        50% { transform: scale(1.2); opacity: 0.8; }
        100% { transform: scale(0); opacity: 0; }
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-4px); }
        75% { transform: translateX(4px); }
    }

    .shake {
        animation: shake 0.3s ease-in-out;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.4; }
    }

    /* --- Responsive: Mobile (<600px) --- */
    @media (max-width: 600px) {
        .viking-app {
            padding: var(--space-3);
            gap: var(--space-3);
        }

        .board {
            max-width: 100vw;
            gap: 0;
        }

        .game-over-text {
            font-size: 1.75rem;
        }

        .btn {
            padding: 0.625rem 1rem;
            font-size: 1rem;
            min-height: 44px;
        }

        .toolbar {
            gap: var(--space-1);
        }

        .status-bar {
            flex-direction: column;
            gap: var(--space-2);
            text-align: center;
        }

        .rules-content {
            padding: var(--space-4);
        }

        .p2p-connect {
            padding: var(--space-3);
        }
    }

    /* --- Accessibility: Reduced Motion --- */
    @media (prefers-reduced-motion: reduce) {
        .particle { animation: none; }
        .move-trail { transition: none; animation: none; }
        .square { transition: none; }
        .animating { animation: none; }
        .game-over-text { animation: none; }
        .btn { transition: none; }
        .piece-svg { transition: none; }
        .p2p-status-dot.connecting { animation: none; }
    }

    /* --- Accessibility: High Contrast --- */
    @media (prefers-contrast: more) {
        :root {
            --board-bg: #000;
            --square-light: #f5e6c8;
            --text-primary: #fff;
            --text-secondary: #ddd;
            --accent: #ff0;
        }
        .square { border: 2px solid #000; }
        .btn { border-width: 2px; }
        .square-corner { border-width: 3px; }
        .status-bar { border-width: 2px; }
    }

    /* --- Dark Mode Enhancement --- */
    @media (prefers-color-scheme: dark) {
        :root {
            --board-bg: #1a0f05;
            --square-light: #3d2a14;
            --text-primary: #e0d5c0;
        }
    }

    /* --- Focus Visible --- */
    .square:focus-visible {
        outline: 2px solid #fff;
        outline-offset: -2px;
        z-index: 2;
    }

    /* Piece SVG sizing */
    .piece-svg-attacker, .piece-svg-defender, .piece-svg-king {
        width: 85%;
        height: 85%;
    }
    """

    static func render() -> [AnyNode] {
        let style = Element<AnyHTMLContext>(
            tag: "style",
            attributes: [],
            children: [AnyNode(Text(css))]
        )
        return [AnyNode(style)]
    }
}
