// MARK: - Viking SVG Design Specifications
// Authentic piece designs based on actual archaeological finds:
//
// ATTACKER (Viking Raider):
//   Round shield with iron boss — based on Gokstad ship shields (c. 900 CE)
//   32 shields found in the burial, alternating black/yellow
//   Central iron boss with rivets, wood grain planks, iron rim
//   Crossed axes behind shield — Mammen axe style (silver-inlaid)
//
// DEFENDER (Saxon/Norse Defender):
//   Kite/heater shield — later Viking Age / early medieval defense
//   Painted with simple heraldic device (cross or chevron)
//   Lighter colors — lime-washed linden wood
//
// KING (Norse King):
//   Crown inspired by Scandinavian royal imagery from rune stones
//   Jelling-style animal ornament crown
//   Larger shield with more elaborate decoration
//   Gold rim and inlay details
//
// BOARD ORNAMENTS:
//   Corner squares: Valknut (three interlocked triangles) — Odin's symbol
//   Throne square: Helm of Awe (Ægishjálmur) — protection stave
//   Board frame: Simplified Urnes-style knotwork border
//   Coordinate labels: Elder Futhark-inspired styling

import LINKER

// MARK: - Authentic Viking SVG Piece Designs

struct VikingPieceSVG {

    // MARK: - Attacker: Gokstad Shield + Mammen Axe

    /// Viking raider piece — round shield with iron boss and crossed axes
    /// Based on Gokstad ship burial shields (900 CE)
    /// Colors: dark iron/charcoal with gold/bronze details
    static func attacker() -> [AnyNode] {
        // Outer rim — iron edge
        let rim = circle(cx: 20, cy: 20, r: 17, fill: VikingColors.ironGrey, stroke: "#4a4440", strokeWidth: 1)

        // Shield body — dark stained wood
        let shield = circle(cx: 20, cy: 20, r: 15, fill: VikingColors.oakHeart, stroke: VikingColors.ironGrey, strokeWidth: 1.5)

        // Wood grain lines (horizontal planks)
        let plank1 = line(x1: 6, y1: 14, x2: 34, y2: 14, stroke: "rgba(0,0,0,0.15)", strokeWidth: 0.5)
        let plank2 = line(x1: 8, y1: 20, x2: 32, y2: 20, stroke: "rgba(0,0,0,0.15)", strokeWidth: 0.5)
        let plank3 = line(x1: 6, y1: 26, x2: 34, y2: 26, stroke: "rgba(0,0,0,0.15)", strokeWidth: 0.5)

        // Central boss — iron dome
        let bossOuter = circle(cx: 20, cy: 20, r: 5, fill: VikingColors.ironGrey, stroke: "#4a4440", strokeWidth: 1)
        let bossInner = circle(cx: 20, cy: 20, r: 2.5, fill: "#7a7570", stroke: "none", strokeWidth: 0)

        // Boss rivets (4 cardinal points)
        let rivet1 = circle(cx: 20, cy: 13, r: 1, fill: VikingColors.ironGrey, stroke: "none", strokeWidth: 0)
        let rivet2 = circle(cx: 20, cy: 27, r: 1, fill: VikingColors.ironGrey, stroke: "none", strokeWidth: 0)
        let rivet3 = circle(cx: 13, cy: 20, r: 1, fill: VikingColors.ironGrey, stroke: "none", strokeWidth: 0)
        let rivet4 = circle(cx: 27, cy: 20, r: 1, fill: VikingColors.ironGrey, stroke: "none", strokeWidth: 0)

        // Crossed axes behind (Mammen-style) — simplified silhouette
        let axe1 = path(d: "M8 8 L12 12 L10 14 L6 10 Z", fill: VikingColors.agedGold, stroke: VikingColors.oakHeart, strokeWidth: 0.5)
        let axe2 = path(d: "M32 8 L28 12 L30 14 L34 10 Z", fill: VikingColors.agedGold, stroke: VikingColors.oakHeart, strokeWidth: 0.5)
        let haft1 = line(x1: 8, y1: 8, x2: 20, y2: 20, stroke: VikingColors.birchBark, strokeWidth: 1)
        let haft2 = line(x1: 32, y1: 8, x2: 20, y2: 20, stroke: VikingColors.birchBark, strokeWidth: 1)

        return [AnyNode(svgContainer(
            className: "piece-svg piece-svg-attacker",
            children: [axe1, haft1, axe2, haft2, rim, shield, plank1, plank2, plank3, bossOuter, bossInner, rivet1, rivet2, rivet3, rivet4].map { AnyNode($0) }
        ))]
    }

    // MARK: - Defender: Lime Shield + Cross Device

    /// Defender piece — lighter shield with painted cross
    /// Based on Anglo-Saxon/Norse defensive shields
    /// Colors: light wood (bone/vellum) with green cross
    static func defender() -> [AnyNode] {
        // Shield body — lime-washed linden wood
        let shield = circle(cx: 20, cy: 20, r: 16, fill: VikingColors.boneWhite, stroke: VikingColors.hackSilver, strokeWidth: 1.5)

        // Painted cross — pre-clipped to fit within shield radius (no clipPath needed)
        // Vertical bar clipped to circle at r=15, x=18..22
        let crossV = path(d: "M18 5.4 L22 5.4 L22 34.6 L18 34.6 Z", fill: VikingColors.verdigris, stroke: "none", strokeWidth: 0)
        // Horizontal bar clipped to circle
        let crossH = path(d: "M5.4 18 L34.6 18 L34.6 22 L5.4 22 Z", fill: VikingColors.verdigris, stroke: "none", strokeWidth: 0)

        // Iron boss — smaller than attacker
        let boss = circle(cx: 20, cy: 20, r: 4, fill: VikingColors.hackSilver, stroke: VikingColors.ironGrey, strokeWidth: 1)
        let bossDot = circle(cx: 20, cy: 20, r: 1.5, fill: VikingColors.ironGrey, stroke: "none", strokeWidth: 0)

        // Iron rim
        let outerRim = circle(cx: 20, cy: 20, r: 16.5, fill: "none", stroke: VikingColors.ironGrey, strokeWidth: 1)

        return [AnyNode(svgContainer(
            className: "piece-svg piece-svg-defender",
            children: [AnyNode(shield), AnyNode(crossV), AnyNode(crossH), AnyNode(outerRim), AnyNode(boss), AnyNode(bossDot)]
        ))]
    }

    // MARK: - King: Ornate Crown + Grand Shield

    /// King piece — golden crown atop larger decorated shield
    /// Crown inspired by Jelling stone art style
    /// Gold details, larger scale to show importance
    static func king() -> [AnyNode] {
        // Grand shield — gold-rimmed
        let shieldOuter = circle(cx: 20, cy: 21, r: 15, fill: VikingColors.boneWhite, stroke: VikingColors.meadGold, strokeWidth: 2)

        // Shield cross in verdigris — pre-clipped to shield bounds
        let crossV = path(d: "M18 7.4 L22 7.4 L22 34.6 L18 34.6 Z", fill: VikingColors.verdigris, stroke: "none", strokeWidth: 0)
        let crossH = path(d: "M6.4 19 L33.6 19 L33.6 23 L6.4 23 Z", fill: VikingColors.verdigris, stroke: "none", strokeWidth: 0)

        // Crown — 3-point crown above shield
        // Inspired by medieval Scandinavian crown depictions
        let crownBase = path(
            d: "M10 10 L14 4 L17 8 L20 2 L23 8 L26 4 L30 10 L28 12 L12 12 Z",
            fill: VikingColors.meadGold,
            stroke: VikingColors.agedGold,
            strokeWidth: 1
        )

        // Crown jewels — 3 small circles at peaks
        let gem1 = circle(cx: 14, cy: 5, r: 1.2, fill: VikingColors.madderRed, stroke: VikingColors.agedGold, strokeWidth: 0.5)
        let gem2 = circle(cx: 20, cy: 3, r: 1.5, fill: VikingColors.madderRed, stroke: VikingColors.agedGold, strokeWidth: 0.5)
        let gem3 = circle(cx: 26, cy: 5, r: 1.2, fill: VikingColors.madderRed, stroke: VikingColors.agedGold, strokeWidth: 0.5)

        // Gold boss
        let boss = circle(cx: 20, cy: 21, r: 4, fill: VikingColors.meadGold, stroke: VikingColors.agedGold, strokeWidth: 1)
        let bossInner = circle(cx: 20, cy: 21, r: 2, fill: VikingColors.brightGold, stroke: "none", strokeWidth: 0)

        return [AnyNode(svgContainer(
            className: "piece-svg piece-svg-king",
            children: [AnyNode(shieldOuter), AnyNode(crossV), AnyNode(crossH), AnyNode(boss), AnyNode(bossInner), AnyNode(crownBase), AnyNode(gem1), AnyNode(gem2), AnyNode(gem3)]
        ))]
    }

    // MARK: - Board Ornaments

    /// Valknut symbol for corner squares — three interlocked triangles
    /// Found on the Stora Hammars stone, Gotland (700-800 CE)
    /// Associated with Odin, the slain, and fate
    static func valknut(size: Int = 20) -> Element<AnyHTMLContext> {
        let s = Double(size)
        let cx = s / 2
        let cy = s / 2
        let r = s * 0.35

        // Three interlocked triangles (simplified)
        let tri1 = "M\(cx) \(cy - r) L\(cx - r * 0.866) \(cy + r * 0.5) L\(cx + r * 0.866) \(cy + r * 0.5) Z"
        let tri2 = "M\(cx) \(cy + r) L\(cx - r * 0.866) \(cy - r * 0.5) L\(cx + r * 0.866) \(cy - r * 0.5) Z"
        let tri3 = "M\(cx - r) \(cy) L\(cx + r * 0.5) \(cy - r * 0.866) L\(cx + r * 0.5) \(cy + r * 0.866) Z"

        let p1 = path(d: tri1, fill: "none", stroke: VikingColors.meadGold, strokeWidth: 1.5)
        let p2 = path(d: tri2, fill: "none", stroke: VikingColors.meadGold, strokeWidth: 1.5)
        let p3 = path(d: tri3, fill: "none", stroke: VikingColors.meadGold, strokeWidth: 1.5)

        return Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 \(size) \(size)"),
                Attribute(name: "width", value: "\(size)"),
                Attribute(name: "height", value: "\(size)"),
                Attribute(name: "class", value: "corner-valknut"),
                Attribute(name: "aria-hidden", value: "true")
            ],
            children: [AnyNode(p1), AnyNode(p2), AnyNode(p3)]
        )
    }

    /// Helm of Awe (Aegishjalmur) for throne square
    /// Icelandic magical stave — 8-armed radial symmetry
    /// Protection symbol, found in Galdrabok (17th c. manuscript, earlier origins)
    /// All coordinates precomputed — no trig functions needed for embedded Swift
    static func helmOfAwe(size: Int = 24) -> Element<AnyHTMLContext> {
        // Precomputed for size=24: center=12, armLen=8.4
        // 8 arms at 0, 45, 90, 135, 180, 225, 270, 315 degrees
        // cos/sin values: 0 -> (1,0), 45 -> (0.707,0.707), 90 -> (0,1), etc.
        let arms: [(ex: Double, ey: Double, fx1: Double, fy1: Double, fx2: Double, fy2: Double)] = [
            // 0 deg: right
            (20.4, 12.0, 20.4, 10.08, 20.4, 13.92),
            // 45 deg: down-right
            (17.94, 17.94, 16.58, 16.58, 19.30, 19.30),
            // 90 deg: down
            (12.0, 20.4, 10.08, 20.4, 13.92, 20.4),
            // 135 deg: down-left
            (6.06, 17.94, 4.70, 19.30, 7.42, 16.58),
            // 180 deg: left
            (3.6, 12.0, 3.6, 13.92, 3.6, 10.08),
            // 225 deg: up-left
            (6.06, 6.06, 7.42, 7.42, 4.70, 4.70),
            // 270 deg: up
            (12.0, 3.6, 13.92, 3.6, 10.08, 3.6),
            // 315 deg: up-right
            (17.94, 6.06, 19.30, 4.70, 16.58, 7.42)
        ]

        var children: [AnyNode] = []
        let cx = 12.0
        let cy = 12.0

        for arm in arms {
            let armLine = line(x1: cx, y1: cy, x2: arm.ex, y2: arm.ey, stroke: VikingColors.meadGold, strokeWidth: 1.5)
            let fork1 = line(x1: arm.ex, y1: arm.ey, x2: arm.fx1, y2: arm.fy1, stroke: VikingColors.meadGold, strokeWidth: 1)
            let fork2 = line(x1: arm.ex, y1: arm.ey, x2: arm.fx2, y2: arm.fy2, stroke: VikingColors.meadGold, strokeWidth: 1)
            children.append(AnyNode(armLine))
            children.append(AnyNode(fork1))
            children.append(AnyNode(fork2))
        }

        // Center dot
        let center = circle(cx: cx, cy: cy, r: 2, fill: VikingColors.meadGold, stroke: "none", strokeWidth: 0)
        children.append(AnyNode(center))

        return Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 \(size) \(size)"),
                Attribute(name: "width", value: "\(size)"),
                Attribute(name: "height", value: "\(size)"),
                Attribute(name: "class", value: "throne-helm"),
                Attribute(name: "aria-hidden", value: "true")
            ],
            children: children
        )
    }

    // MARK: - SVG Helpers

    private static func svgContainer(className: String, children: [AnyNode]) -> Element<AnyHTMLContext> {
        Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 40 40"),
                Attribute(name: "width", value: "40"),
                Attribute(name: "height", value: "40"),
                Attribute(name: "class", value: className),
                Attribute(name: "role", value: "img")
            ],
            children: children
        )
    }

    private static func circle(cx: Double, cy: Double, r: Double, fill: String, stroke: String, strokeWidth: Double) -> Element<AnyHTMLContext> {
        var attrs = [
            Attribute(name: "cx", value: "\(cx)"),
            Attribute(name: "cy", value: "\(cy)"),
            Attribute(name: "r", value: "\(r)"),
            Attribute(name: "fill", value: fill)
        ]
        if stroke != "none" {
            attrs.append(Attribute(name: "stroke", value: stroke))
            attrs.append(Attribute(name: "stroke-width", value: "\(strokeWidth)"))
        }
        return Element<AnyHTMLContext>(tag: "circle", attributes: attrs, children: [])
    }

    private static func path(d: String, fill: String, stroke: String, strokeWidth: Double) -> Element<AnyHTMLContext> {
        var attrs = [
            Attribute(name: "d", value: d),
            Attribute(name: "fill", value: fill)
        ]
        if stroke != "none" {
            attrs.append(Attribute(name: "stroke", value: stroke))
            attrs.append(Attribute(name: "stroke-width", value: "\(strokeWidth)"))
        }
        return Element<AnyHTMLContext>(tag: "path", attributes: attrs, children: [])
    }

    private static func line(x1: Double, y1: Double, x2: Double, y2: Double, stroke: String, strokeWidth: Double) -> Element<AnyHTMLContext> {
        Element<AnyHTMLContext>(
            tag: "line",
            attributes: [
                Attribute(name: "x1", value: "\(x1)"),
                Attribute(name: "y1", value: "\(y1)"),
                Attribute(name: "x2", value: "\(x2)"),
                Attribute(name: "y2", value: "\(y2)"),
                Attribute(name: "stroke", value: stroke),
                Attribute(name: "stroke-width", value: "\(strokeWidth)")
            ],
            children: []
        )
    }

    // Int overloads for convenience
    private static func circle(cx: Int, cy: Int, r: Int, fill: String, stroke: String, strokeWidth: Int) -> Element<AnyHTMLContext> {
        circle(cx: Double(cx), cy: Double(cy), r: Double(r), fill: fill, stroke: stroke, strokeWidth: Double(strokeWidth))
    }

    private static func line(x1: Int, y1: Int, x2: Int, y2: Int, stroke: String, strokeWidth: Int) -> Element<AnyHTMLContext> {
        line(x1: Double(x1), y1: Double(y1), x2: Double(x2), y2: Double(y2), stroke: stroke, strokeWidth: Double(strokeWidth))
    }
}
