# ORBITAL — Battle UI

Companion to [DESIGN.md](DESIGN.md), [ARCHITECTURE.md](ARCHITECTURE.md), [ECONOMY_AND_CONTENT.md](ECONOMY_AND_CONTENT.md). What's on screen during a battle and how it behaves. Node ownership + signal routing live in ARCHITECTURE; this is the content inventory.

> **Status:** draft. Pixel layout (placement/sizing on the vertical screen) is settled at mockup stage. Open questions at the bottom.

Scope: **battle scene only**. Resupply / Home / tech-tree internals are separate.

---

## Layers

Five buckets, by how each element lives on screen.

### A. Persistent HUD
Always visible (`BattleUI` CanvasLayer).

| Element | Shows / does |
|---|---|
| **Material** | icon + count |
| **Alien Cores** | icon + count |
| **Base HP** | number + bar |
| **Level** | current level (~10 per run) |
| **Wave meter** | time-based bar draining over the current wave; spawning stops when it empties, then mop up stragglers |
| **Speed controls** | pause / fast-forward |
| **Buttons** | Tech Tree, Pause, Dev (dev-only) |

### B. Tap-contextual menus
Live — no pause. Tap a hex → the right one opens (ARCHITECTURE build flow).

| Menu | Trigger | Contents |
|---|---|---|
| **BuildMenu** | tap empty hex | pick/buy a defense; cost; greyed if unaffordable; range preview |
| **StructureCard** | tap occupied hex | stats; per-defense upgrade (Material); targeting priority (closest / furthest / spot); aim-nudge; sell/refund |

### C. Pause overlays
Pause gameplay (`process_mode = WHEN_PAUSED`).

| Overlay | Purpose |
|---|---|
| **TechTree** | spend Cores on capabilities |
| **PauseMenu** | resume / settings / quit |
| **DevTools** | meta perks, restart level, give gold, clear enemies, save/load points |

### D. In-world feedback
Not menus — drawn in the field.
- Floating **damage numbers**
- Enemy **HP bars**
- Hex **highlight** on tap; **range circle** when placing/selecting
- **Cores-gained / reward** feedback on kill
- Later: hit anims, defeat indicator, "can't afford" toast

### E. Manual control
- **Hold-to-fire-at** — while a screen point is held, defenses fire toward it. Light micro over autonomous targeting (see ECONOMY Battle behavior).

---

## Open questions
1. Which defenses obey fire-at — all, or only aim-nudge-capable?
2. Speed set — fast-forward at 2× only, or 2×/3×?
3. Wave system — one wave per level for now; when do multi-wave levels + a "Wave X / N" readout land?
4. Vertical-screen layout — single top bar vs. split top/bottom; thumb-reach for the menus. (Mockup.)
5. Sell/refund rate.
