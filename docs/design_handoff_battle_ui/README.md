# Handoff: Space Defense — Battle UI (Layout B)

## Overview
A mobile (portrait) in-battle HUD for a sci-fi **tower-defense** game. The player watches enemies advance down a starfield toward a planet, places/upgrades defensive turrets on a hex grid, controls game speed, and spends a premium currency in a Tech Tree. This package documents four representative UI states.

## About the Design Files
The files in this bundle (`*.dc.html`, `*.html`) are **design references created in HTML** — prototypes that show the intended look, layout, and behavior. They are **not production code to copy directly**. They use a small in-house templating runtime (`support.js`) that you should ignore.

Your task is to **recreate these designs in the target codebase's existing environment** — most likely a game/app stack (React Native, Unity uGUI/UI Toolkit, SwiftUI, Flutter, a web canvas/React layer, etc.) — using its established components, layout system, and asset pipeline. If no environment exists yet, pick the most appropriate framework for a real-time mobile game UI and implement there. Match the visual spec precisely; adapt the structure to native idioms.

## Fidelity
**High-fidelity.** Final colors, typography, spacing, and component states are specified. Recreate the UI pixel-accurately using the codebase's libraries. The one exception is the battlefield artwork (turrets, enemies, planet, beams), which is **schematic/placeholder** — built from CSS shapes to communicate composition and color. Replace those with real game sprites/art; keep their on-screen positions, scale relationships, and glow colors.

## Canvas & Frame
- Designed for a phone screen at **376 × 842 px** (the visible area inside the device bezel; the mockup wraps it in a 400×866 bezel with a 12px frame and a notch). Treat **376×842** as the reference safe area.
- iOS-style chrome present in the mock: status bar (time `9:41` top-left, battery glyph top-right), a centered notch pill, and a home indicator bar at the bottom. These are OS chrome — use the platform's real status bar / safe-area insets, don't recreate them.
- Layout is **edge-to-edge**: the battlefield fills the whole screen; HUD panels float on top as overlays.

## Layering (z-order, bottom → top)
1. Battlefield scene (starfield, planet, hex grid, turrets, enemies, weapon fire, damage numbers)
2. Tech-tree dim/blur scrim (only in the Tech Tree state)
3. Top status HUD bar / floating panels (build card, structure card, tech tree panel) — all `z-index ~30–35`
4. OS chrome (status bar text, notch, home indicator) — `z-index ~55–60`

---

## Screens / Views

There is **one screen** (the battle) with **four UI states**. The persistent elements (battlefield, top status HUD, bottom action bar) are shared; each state adds or swaps a panel.

### Persistent — Battlefield (background, always present)
- **Purpose**: The play space. Enemies spawn top/sides and move toward the planet at the bottom; turrets sit on a hex grid and fire.
- **Layout**: Absolute, fills screen. Background is a vertical radial gradient (deep violet at top → dark teal-navy at bottom), with:
  - **Starfield**: ~20 small star dots, 1–1.4px, colors `#dff0ff` / `#9fc6dd` at varying opacity, scattered.
  - **Planet**: large ellipse anchored off the bottom edge, centered; dark teal radial fill with a bright cyan top rim (`2px solid #3fd0e6`) and a soft cyan glow above it. This is the line the player defends.
  - **Teal ambient glow**: large soft radial, lower-right, `rgba(46,196,176,0.22)`.
  - **Hex grid**: two offset rows of flat-top hexagons (cells **46×52px**, gap 5px; row 2 offset `margin-top:-12px; margin-left:26px` to interlock), anchored `bottom:116px`. Each cell = a turret slot. Empty cells are faint outlines; occupied cells show a turret glyph.
  - **Enemies**: two archetypes — **Dart** (pink chevron/arrow, `#ec5f9b`→`#f7a8cd`, white cockpit dot) and **Orb** (orange sphere `#ff7038`→`#ffc79c`, some with a cyan shield arc beneath). ~9 on screen at staggered positions.
  - **Weapon fire**: thin cyan beams (`#9becf5`) from turret positions up toward enemies, plus a white muzzle-flash dot with cyan glow.
  - **Damage numbers**: monospace floating combat text, e.g. `-180` (cyan) and `-95!` (white = crit).
- **Note**: This whole layer is placeholder art — swap for real sprites, keep colors/positions.

### Persistent — Top Status HUD
- **Purpose**: At-a-glance economy + run progress, plus access to the menu/pause.
- **Layout**: Floating rounded bar pinned `top:50px, left/right:10px`. Glassy: `background:rgba(10,18,28,0.72)` + `backdrop-filter:blur(14px)`, `border:1px solid rgba(63,208,230,0.18)`, `border-radius:14px`, `padding:9px 12px 9px 14px`, shadow `0 8px 24px rgba(0,0,0,0.4)`. Flex row, `space-between`.
- **Components**:
  - **Left — resources**: two pills.
    - **Material**: green hexagon swatch (`#52e6a0`) + value `340` (JetBrains Mono, 15px, 700, `#e3ecf7`).
    - **Alien Cores**: purple diamond (`#b07bff`, rotated square) + value `5`.
  - **Center (absolutely centered) — progress**: a cyan **LVL** badge (`rgba(63,208,230,0.16)` fill, `1px solid rgba(63,208,230,0.55)`, glow) showing `LVL 3`, then `WAVE 2/4` in monospace, 12px, `#9fb2c4` with the current number in `#cfe0ea`.
  - **Right — Menu/Pause button** *(moved here in latest revision)*: 30×30, `border-radius:9px`, `background:rgba(255,255,255,0.06)`, `border:1px solid rgba(63,208,230,0.22)`. Icon = 3 stacked bars (13×2px, `#cfe0ea`, 1px radius, 3px gap). Opens the pause/menu overlay (holds pause).

### Persistent — Bottom Action Bar
- **Purpose**: Speed control, hull health readout, and Tech Tree access. Present in states 1–3 (the Tech Tree state replaces it with its panel).
- **Layout**: Docked flush to the bottom edge, full width. `background:rgba(8,14,22,0.93)` + `blur(16px)`, `border-top:1px solid rgba(63,208,230,0.25)`, `padding:13px 16px 26px` (extra bottom padding clears the home indicator), shadow `0 -10px 30px rgba(0,0,0,0.45)`. Flex row, `gap:13px`, vertically centered.
- **Components (left → right)**:
  - **Speed toggle**: pill, `rgba(63,208,230,0.14)` fill, `1px solid rgba(63,208,230,0.42)`, `border-radius:12px`, `padding:9px 13px`. Two small cyan play triangles + label `2×` (mono, 15px, 700, `#3fd0e6`). **Cycles** game speed on tap (e.g. 1× → 2× → 3×).
  - **Hull HP readout** (flex:1): a cyan hexagon ship icon, then a **segmented bar** of 10 cells (each `flex:1`, `height:10px`, `border-radius:2px`, `gap:2px`); filled cells `#3fd0e6` with glow, empty cells `rgba(255,255,255,0.12)`. Mock shows **8/10 filled**. Trailing mono value `1890` (`#cfe0ea`). Represents the planet/base hull integrity.
  - **Tech Tree button** *(was a hamburger menu; now the Tech Tree entry)*: 42×42, `border-radius:12px`, **purple** theme — `background:rgba(176,123,255,0.12)`, `border:1px solid rgba(176,123,255,0.42)`, glow `0 0 10px rgba(176,123,255,0.18)`. Icon = a small **branching node tree** in `#b07bff` (one top node, two lines down to two leaf nodes) with a tiny `TECH` label (mono, 6px, `#c9aaff`, 700). Opens the Tech Tree (state 4).

---

### State 1 — Active Fight
- Battlefield + top HUD + bottom bar, nothing else. The "resting" combat state. No hex cell highlighted.

### State 2 — Build Menu (live, no pause)
- **Trigger**: tapping an **empty** hex cell.
- The tapped cell shows a **range-preview ring** (dashed cyan circle ~186px + soft cyan radial fill) and a **ghost turret** at 42% opacity.
- A **compact Build card** docks **opposite the tapped hex** so the field stays visible — `position:absolute; right:10px; bottom:104px; width:190px`. Glassy panel: `rgba(8,14,22,0.94)` + `blur(16px)`, `1px solid rgba(63,208,230,0.28)`, `border-radius:16px`.
  - Header: `BUILD · B4` + a `×` close chip.
  - List rows, each: circular turret-icon mount (22px) + name + cost. Items:
    - Railgun — `120` material (green hex)
    - Pulse Laser — `90` material
    - Flak Cannon — `160` material
    - Arc Coil — `2` Alien Cores (purple diamond)
    - Missile — `220` material, **disabled** (opacity 0.5)
    - Drone Bay — locked, shows `TECH` tag (requires tech-tree unlock)
  - Rows separated by `1px solid rgba(120,150,210,0.1)` top borders.
- **Crucially does NOT pause** — wave keeps advancing while the half-width card is open.

### State 3 — Structure Card (live, no pause)
- **Trigger**: tapping an **occupied** hex cell (existing turret).
- The cell gets a solid cyan **selection hex ring** behind it + the same range preview ring.
- A **compact Structure card** docks opposite the hex — `right:10px; bottom:104px; width:196px`, same glass treatment.
  - **Header**: turret icon (28px mount) + name `Railgun Turret` + subtitle `KINETIC · LV 3` (mono, 9px, `#6f8595`).
  - **Stat row**: three tiles (`rgba(255,255,255,0.04)`, radius 8): `DMG 480`, `RATE 0.6`, `RNG 240` (labels 8px `#6f8595`, values mono 13px 700 `#e3ecf7`).
  - **Upgrade button**: gradient cyan bar (`rgba(63,208,230,0.22)→0.1`, `1px solid rgba(63,208,230,0.5)`, radius 11). Text `UPGRADE → 4` + `DMG +120`, right side cost `140` material (green hex).
  - **Targeting** section label, then a 2-segment toggle: **CLOSEST** (selected = solid `#3fd0e6` fill, `#06141c` text) / **FURTHEST** (unselected = faint outline).
  - **Sell** button: `rgba(255,93,82,0.1)` fill, `1px solid rgba(255,93,82,0.35)`, red text `SELL DEFENSE` + green refund `+60`.
- **Also does NOT pause.**

### State 4 — Tech Tree (PAUSES, full-screen)
- **Trigger**: the purple Tech Tree button in the bottom bar.
- **Pauses the game.** The battlefield is **dimmed + blurred** by a scrim: `rgba(5,9,16,0.62)` + `blur(3px)` over the whole field.
- A centered **PAUSED** indicator sits below the notch (two vertical bars + `PAUSED`, mono, 11px, letter-spacing 2px, `#9fb2c4`).
- A near-full-screen **Tech Tree panel**: `top:92px, left/right:14px, bottom:30px`. `rgba(9,16,24,0.94)` + `blur(18px)`, `1px solid rgba(63,208,230,0.3)`, `border-radius:22px`, `padding:16px`, big shadow.
  - **Header**: `TECH TREE` title (18px, 700) + `×` close chip.
  - **Currency line**: purple diamond + `5` + `Alien Cores available`.
  - **Four branches**, each a labeled row of 3 nodes connected by horizontal connector lines:
    - **KINETIC**: Twin Shot (owned ✓) → Pierce (purchasable, costs `✦1`) → Ricochet (locked, dashed + padlock).
    - **ENERGY**: Beam (owned) → Chain (`✦2`) → Shred (locked).
    - **CONTROL**: Pull (`✦1`, available) → Stasis (locked) → EMP (locked).
    - **ECONOMY**: Interest (owned) → Yield (`✦1`, green-tinted) → +Material (locked).
  - **Node states**: owned = filled cyan tile w/ checkmark; available = cyan-outline tile w/ branch glyph; locked = dashed faint tile w/ padlock. `✦N` = Alien Core cost.
  - **Resume button**: full-width gradient cyan (`#2fb6cc→#3fd0e6`), `#06141c` text, `RESUME ▸`. Closes the tree and unpauses.

---

## Interactions & Behavior
- **Tap empty hex** → range ring + ghost turret appear, Build card slides in opposite side. No pause. Tap a build item (if affordable) → places turret, deducts cost. `×` or tap-away → dismiss.
- **Tap occupied hex** → selection ring + range ring, Structure card slides in. No pause. Upgrade deducts cost & bumps level/stats; targeting toggle switches Closest/Furthest; Sell removes turret & refunds.
- **Speed pill** → cycles 1×/2×/3× (and possibly pause). Affects sim tick rate only.
- **Tech Tree button (bottom-right)** → pauses sim, opens full-screen tree with dim+blur. Buying a node spends Alien Cores and unlocks a global capability (may unlock build items like Drone Bay). `RESUME`/`×` → unpause.
- **Menu button (top-right)** → opens pause/menu overlay (settings, quit, etc.); holds pause.
- **Affordability**: items/upgrades the player can't afford render at reduced opacity and are non-interactive.
- **Panels are half-width and side-docked** (Build/Structure) specifically so the battlefield and range preview remain visible during live play — preserve this; do not make them modal/full-width.
- **Transitions**: panels should slide/fade in from their docked edge; range ring can pulse subtly. (Durations unspecified — use the codebase's standard ~150–250ms ease-out.)

## State Management
- `gameSpeed`: 1 | 2 | 3 (and paused flag).
- `paused`: boolean — true while Tech Tree or Menu overlay is open.
- `selectedCell`: null | { id, occupant } — drives Build vs Structure card.
- `resources`: { material:number, alienCores:number }.
- `level`, `wave`, `waveCount`; `hullSegments` (filled/total), `hullValue`.
- `turrets`: per-cell { type, level, targeting:'closest'|'furthest', stats }.
- `techNodes`: per-node { branch, owned:boolean, cost, locked:boolean } — gates some build items.
- Build/upgrade/sell mutate resources + turrets; tech purchases mutate alienCores + techNodes.

## Design Tokens

**Colors**
- Background gradient (field): violet `#2c2160` → `#1b1a48` → `#131a3a` → `#0d1730` → `#0a1422`.
- Panel surfaces: `rgba(10,18,28,0.72)` (top HUD), `rgba(8,14,22,0.93)` (bottom bar), `rgba(8,14,22,0.94)` (cards), `rgba(9,16,24,0.94)` (tech tree).
- **Cyan (primary/UI/energy)**: `#3fd0e6`; light `#9becf5`; dim `#1f8aa0`.
- **Purple / Alien Core (premium, tech)**: `#b07bff`; light `#c9aaff`.
- **Green / Material (economy)**: `#52e6a0`.
- **Pink (Dart enemy)**: `#ec5f9b` / `#f7a8cd`.
- **Orange (Orb enemy)**: `#ff7038` / `#ffc79c`.
- **Red (sell / danger)**: `#ff5d52`, text `#ff8a7e`.
- Text: primary `#e3ecf7` / `#cfe0ea`; muted `#9fb2c4`, `#7185a0`, `#6f8595`.
- Border accent: `rgba(63,208,230,0.18–0.55)` (cyan), `rgba(176,123,255,0.42)` (purple).

**Typography**
- **Chakra Petch** (Google Fonts) — UI labels, titles, buttons. Weights 400/500/600/700.
- **JetBrains Mono** (Google Fonts) — all numbers, costs, codes, stat values. Weights 400/500/700.
- Scale: titles 18px/700; section labels 11–13px/600–700 (often letter-spacing 1–2px); body 11–13px; stat values 13–15px mono; micro labels 8–9px.

**Radii**: chips/icons 6–12px; cards 14–16px; tech panel 22px; device frame 44–54px; pills/segments 8–12px.

**Spacing**: panel padding 9–16px; card row padding ~6px; bar gap 13px; list gaps 5–8px. Bottom bar reserves `26px` bottom padding for the home indicator.

**Shadows / Glass**: panels use `backdrop-filter: blur(14–18px)`; drop shadows `0 8px 24px` to `0 20px 60px rgba(0,0,0,0.4–0.6)`; neon glows via `box-shadow: 0 0 5–12px <accent>`.

**Iconography** (currently CSS shapes — convert to your icon set, keep meaning + color):
- Material = filled **hexagon**, green. Alien Core = **diamond** (rotated square), purple.
- Turret glyphs: Railgun = vertical bar; Pulse = ring; Flak = small hexagon; Missile = trio of triangles; Arc = diamond outline; Factory = green hexagon.
- Hex cells = flat-top hexagon `clip-path: polygon(50% 0,100% 25%,100% 75%,50% 100%,0 75%,0 25%)`.

## Assets
No external image/raster assets — all artwork is CSS/`React.createElement` placeholder geometry. For production, supply real sprites for: turrets (6 types), enemies (Dart, Orb, shielded variants), planet, weapon beams/muzzle flashes, and an icon set for resources/tech nodes. Fonts are the two Google Fonts above (or your in-house equivalents).

## Files
Included in this bundle:
- `Battle UI Mockup.dc.html` — the four-frame mockup (all states side by side). **Primary reference.**
- `Battlefield.dc.html` — the reusable battlefield scene (gradient, starfield, planet, hex grid, turrets, enemies, fire, damage numbers). Driven by two inputs: `mode` (`normal`/`placing`/`inspecting`) and `highlight` (hex cell id).
- `Battle UI Mockup (standalone).html` — self-contained single-file version that opens in any browser with no runtime (easiest to view; open this first).

> The `.dc.html` files reference a small runtime (`support.js`) — ignore it; it's not part of the design. The standalone HTML needs nothing.
