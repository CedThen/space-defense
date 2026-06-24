# ORBITAL — Economy & Content Draft

Companion to [DESIGN.md](DESIGN.md) and [ARCHITECTURE.md](ARCHITECTURE.md). First-pass catalog of resources, economy buildings, placement layers, defenses, the combine mechanic, upgrades, skill tree, and enemies.

> **Status:** brainstorm / first draft. Numbers are placeholders. Open questions at the bottom.

---

## Resources

Two-resource economy, SC2-style: a high-flow primary and a scarce gating secondary.

| Resource | Role | Sources | Spent on |
|---|---|---|---|
| **Material** | Primary, high-flow | Enemy kills, factories, carryover, interest | Defenses, economy buildings, gamba |
| **Alien Cores** | Secondary, scarce | Drops from stronger enemies only — elites/miniboss/boss | Skill tree, rare-tier defenses, powerful buildings, respec/reroll |

Primary is **Material** so factories that produce it make sense — gold reads as loot, not manufacturing. Alien Cores are exploratory and may be scrapped.

### Material economy
- **Per-level Material:** baseline grant on clearing a level, scaling with level number.
- **Kill Material:** enemies drop Material on death.
- **Interest:** unspent Material earns a % per Resupply, capped, TFT-style — makes save-vs-spend mathematically real.
- **Factories:** placed structures producing passive Material/wave.

### Alien Cores
Only from killing stronger enemies — no economy building produces them. Roughly **2–3 per wave**. Expensive tech and structures cost one, sometimes two. The scarce, saved-up resource for tech and high-end builds. Mirrors vespene gas: gates a category Material can't touch.

---

## Placement layers

Screen space is at a premium on a vertical phone. Three stacked layers, bottom-anchored.

| Layer | Screen region | What goes here |
|---|---|---|
| **Ground band** | Bottom ~1/5, terrestrial | Most defenses. Shoot upward; some allow aim-nudging. Factories. |
| **Orbital platforms** | Mid-screen | Platform-mounted defenses, support structures |
| **Deep / satellite** | Far up | Long-range or far-out placements, satellites, mines |

**Aim-nudging:** some ground defenses can have their firing angle adjusted, trading auto-targeting for player-set coverage.

### Orbital platforms — exploratory, post-MVP
Reach the **orbital / deep** layers by spending a **ground tile** to deploy a platform — a second, smaller `HexGrid` arced higher, shown only once unlocked. Hosts range-limited / alternative defenses (`StructureDef.layer = orbital`: mines, satellites). Platforms are **inert pass-through anchors with no HP** — only the base has health; their value is positional reach, their cost is the tile + resources. Destructible platforms (a structure-harassing enemy + targeting AI + per-platform HP UI) are deliberate later complexity, not v1.

### Hex grid
Defenses sit on **2 rows of hexes** (currently 8 cols at ~40px) — TFT's board adapted, much softer: placement is small optimizations, not a primary skill axis. Interior cells have ~4 neighbors, feeding the **adjacency combos** below. Lines up with the 12–16 tile scale target.

Open: how the hex board maps onto the three layers — hexes in the ground band with orbital/deep as separate slots, or rows spanning layers?

---

## Battle behavior

- **Build/place is live, mid-battle.** Spending/placement at Resupply likely allowed too.
- Defenses act **autonomously** — no per-shot micro.
- Player sets **targeting priority** per defense where it fits: closest / furthest / specific spot.
- **Manual fire-at (hold to direct):** holding a point on the screen overrides auto-target — defenses fire toward that spot while held. Light optional micro over the autonomous baseline. Open: which defenses obey (all vs. aim-nudge-capable only), and how it composes with per-defense priority.
- Delivery types: **projectiles** (varied trajectories and effects), **beams**, **drones** (launched, fly around).
- Defenses are **stationary** — no movement unless a compelling design reason shows up.
- Enemy AI and spawn mechanics: deferred.

---

## Adjacency combos (aura model)

Merging is dropped (too much authoring + power/tile complexity). Instead, **adjacent defenses buff each other via auras** — no tiles freed, no entity replacement.

- Each defense **grants one aura** to neighbors and **receives** theirs. Authoring is O(N) (one aura per defense), not O(N²) pairs. Combos emerge: a *splitter* grants "shots split on hit"; a railgun beside it inherits split — never authored as a pair.
- **Behavior auras** (split, pierce, chain) are **on/off** — significant but non-stacking. **Numeric auras** (+fire rate, +projectiles) **stack with caps / diminishing returns**. Power stays meaningful without runaway scaling.
- Recompute **from scratch** on any neighborhood change: reset to base → loop all neighbors → apply. Idempotent, handles 1–4 neighbors identically. **HexGrid** owns adjacency discovery; **Defense** owns combo logic.
- Power is gated by **assembly cost** — buffer tiles aren't shooting tiles, strong auras sit on costly/teched defenses, forced-diversity enemies punish over-commitment. Let combos be strong; make assembling them a sacrifice.

Open: aura range/stack upgrades; optional authored *pair-specific* marquee combos later.

---

## Economy buildings — the "invest" pillar

Each costs a tile and Material — investing competes for space, not just currency.

| Building | Produces | Notes |
|---|---|---|
| **Factory** | Passive **Material**/wave | Core greed investment. Compounds. Upgradeable yield. |
| **Extractor** — maybe | Burst Material, then depletes | Tempo play vs. the steady Factory. |

---

## Defenses

### DPS core — Material
| Defense | Profile | Strong vs. | Weak vs. |
|---|---|---|---|
| **Railgun Turret** | Single-target, high dmg, slow fire | Armor, high-HP | Swarms |
| **Pulse Laser** | Fast, low per-hit, continuous | Fast movers, swarm | Armor |
| **Flak Cannon** | AoE splash | Grouped swarms | Single big targets |
| **Missile Battery** | Homing, screen-wide, slow reload | Leakers, coverage gaps | Cost-efficiency |
| **Arc / Tesla Coil** | Chains between enemies | Dense packs | Single big targets |
| **Drone Launcher** | Spawns roaming attack drones | Coverage, combos | Direct burst |

### Utility / control
| Defense | Effect |
|---|---|
| **Gravity Well** | Pulls enemies into a clump, slows descent. Force-multiplies Flak/Arc. |
| **Tractor / Stasis Field** | Slows or freezes a zone |
| **EMP Pylon** | Periodically disables enemy abilities |
| **Shield Projector** | Absorbs hits at the base |
| **Mine** — deep layer | One-shot area denial, replaced after detonation |

### Rare tier — Alien Cores
Build-defining, gated behind Cores / gamba. List TBD.

---

## Two upgrade tiers

Two systems doing different jobs, designed to multiply rather than overlap.

- **Tech tree — Alien Cores, qualitative.** Always-on capability unlocks that change *how* defenses behave: extra projectiles, bouncing/piercing shots, chain-on-kill, new firing modes. Run-defining, scarce.
- **Per-defense upgrades — Material, quantitative.** Level a specific placed defense: damage, fire rate, range, crit chance/mult, projectile speed, splash radius, chain count. Cheap, frequent, the main Material sink.

The tree grants capabilities; per-defense upgrades scale them. Tech unlocks bouncing shots for a weapon class, then Material leveling makes those bounces hit harder. Global modifiers like all-DPS %, Material income %, and reroll luck sit on the tree too.

---

## Tech tree — Alien Cores

Visible tree, teched with Cores. Unlocks are **always-on** once bought — no slotting. Nodes grant capabilities, not flat percentages, and apply **class-wide** so teching a branch changes how every defense in that class behaves.

Branch sketch:
- **Kinetic** — extra projectiles, armor-pierce, ricochet
- **Energy** — beam pierce, chain targets, shield-shred
- **Control** — gravity pull radius, stasis duration, EMP into new effects
- **Economy** — interest cap, Factory yield, starting Material

Because unlocks are permanent and class-wide, late-run builds trend powerful — the scarcity of Cores is what keeps players from teching everything. Build identity comes from *which* branches you could afford, plus which powers you slotted (a separate, coexisting system: tree = chosen permanents, powers = random end-of-level drops slotted at Resupply).

Open: branch mutual exclusivity, respec cost, meta-tree gating of which nodes exist.

---

## Enemies — first pass
| Enemy | Behavior | Answer it forces |
|---|---|---|
| **Loiter-drone** | Slow at top, accelerates downward | Burst / front-loaded coverage |
| **Carrier** | Spawns droppers, retreats to regen | EMP / reach |
| **Armored** | High HP, resists kinetic | Railgun / armor-pierce |
| **Shielded** | Absorbs front hits | Energy / EMP |
| **Swarm** | Many weak, fast | Flak / Arc / Gravity |
| **Elite** | Beefed mini-threat, drops Cores | Focus fire, rewards a strong build |

Levels roll different tiers — forced diversity.

### EnemyDef (data-driven)
Each enemy type is an `EnemyDef` resource (mirrors `StructureDef`). **Core** (every enemy): `max_hp`, `speed`, `attack_kind` (ATTACK | SUICIDE), `attack_damage`, `attack_rate`, `attack_range`, sprite, `display_scale`, `race`, resistances, `reward` (material/Cores on death). **Rich** (node-rendered only): move + attack animations, `behavior` (special abilities). Ranged enemies also carry a projectile.

### Lifecycle & damage — siege, not leak
Enemies don't pass the base — they **advance, then attack it until they die**. The base drains while enemies are alive in range, so you win by *killing* them, not by blocking a lane.
- **Advance → attack:** move toward the base until within `attack_range`, then attack continuously (`attack_damage` at `attack_rate`) with an attack animation, until killed. Melee = tiny range (bashes the base); ranged = large range (fires its own projectile).
- **Suicide types:** ignore range — rush the base and self-destruct on contact (deals its `attack_damage` as one hit), then die.
- Enemies persist; the only exits are death or suicide-impact. No leak-through.

### Animations & behaviors
Node enemies get move + attack animations and **pluggable behaviors referenced by the `EnemyDef`** (loiter-accelerate, carrier-spawns-droppers, suicide-rush, …); the movement pattern is one such behavior. Behaviors and animations are node-only.
- **Animation mechanism:** `AnimationPlayer` (keyframe transform/modulate; a *method track* deals damage on the attack's contact frame, `animation_finished` returns to idle) — works with the single-image SVGs now; swap to `AnimatedSprite2D` + sprite sheets once there are real frames.
- **Behavior mechanism:** a small state machine on the enemy (`ADVANCE → ATTACK → DIE`) for the universal flow; special abilities as a per-type component/strategy the `EnemyDef` points to, added only where needed.

### Representation — node vs swarm
**One `EnemyDef` with a `render_mode` flag** (`NODE | MULTIMESH`), not separate types:
- **Node** — individuals, elites, minibosses, bosses, carriers. Rich: animations, abilities, attacks. Hundreds max.
- **Swarm (MultiMesh + data-oriented)** — thousands of cheap units: positions in arrays, one movement loop, instanced rendering, no per-unit node/abilities (shader anim at most).

The spawner routes on the flag; shared core fields apply to both, rich fields are ignored by swarm units.

Open: a separate `SwarmDef` if swarm diverges hard; how behaviors are authored (component vs strategy script vs enum); minibosses/boss as `EnemyDef` + phases.

---

## Run variety & anti-rote opening

The problem: level 1 is fully solved — no pressure, full info — so players default to the same "couple defenses + econ" line every run. Fix is to inject variance the player *sees* before their first placement, while keeping the strategic goal plannable. They still know they want, say, an econ-heavy kinetic build; what changes is how they survive the first few levels to get there.

### Anti-rote opening levers
- **Pre-revealed level-1 wave.** Show wave-1 composition before placement. Swarm one run, armored single-target the next — the correct opening defense shifts. Turns the opening into a reading problem, not a memorized one.
- **Varying starting board.** Level 1 isn't always blank. Sometimes a free defense is pre-placed in a non-ideal spot, sometimes a Factory is pre-built, sometimes a tile is blocked. You build around a given.
- **Starting resource skew.** Some runs start Material-rich/Core-poor, others reversed, others with banked interest. Shifts the optimal first purchase.
- **Opening pact.** A level-1 constraint: no Factories until L3, first defense free but blind-picked from 3, Cores don't drop until L4. Forces a different econ/tech sequence than the default greedy line.

### Wave system
- **Wave archetypes.** Author ~8–10 named shapes — Swarm Rush, Armor Column, Carrier Siege, Mixed Assault — each with its own spawn rhythm and tier weighting. A run rolls a sequence. Same enemy set, very different level feel.
- **Wave tags.** A wave can carry a modifier applied to whatever it spawns — fast, shielded, regenerating, explode-on-death. Combinatorial variety on top of the base enemy set.
- **Races.** A race is a bundle: enemy pool subset + shared weakness/resistance profile + weapon/visual flavor (e.g. races A and C use lasers and robotic weaponry — weak to EMP). A run rolls 1–2 races, shown at start — readable counter-logic that feeds the pre-revealed opening. Races pick *who spawns and what counters them*; archetypes pick *spawn rhythm/shape*. Orthogonal dials.

**Bulwark** race — provisional name. Units carry heavy directional shields and hide behind them, defeating direct line-of-fire projectiles. Forces indirect or disabling answers: Drone Launcher and deep-layer Mines go around, EMP Pylon drops the shields, Gravity Well / Stasis pulls them out of cover. Distinct from the **Shielded** enemy tier, a front-absorb that Energy/EMP already counters; Bulwark is a positional puzzle.

### Curse / pact system — the StS-replacement variety engine
After certain levels, offer 2–3 bidirectional trades. The player steers their own difficulty and economy, which forces different builds run to run.
- "+30% enemy armor, but Cores +1/wave"
- "double enemy speed, but Material income +50%"
- "enemies explode on death, but defense range +20%"

---

## Player factions

Run-start identity, chosen each run, unlocked via meta. A balanced sidegrade, not added power — it shapes the opening and tilts a playstyle. Balance the unlock order so later factions stay sidegrades. Express identity through opening and behavior, not flat stats. Seed is two; plan for 3–4.

| Faction | Identity | Opens with | Tradeoff |
|---|---|---|---|
| **Coalition** — world gov | Econ + control | Pre-built Factory or banked interest; Economy/Control head-start | Slower military ramp; first combat tech costs more |
| **Syndicate** — corp | Combat tempo | A DPS defense pre-unlocked; Kinetic/Energy head-start | Hand-to-mouth economy; no interest, pricier factories |

### Identity past the opening
The defenses/tech/powers deck is shared, so a faction is a lens, not a full class. Three levers, cheap to expensive:
- **Biased offers** — weight the random pools toward the faction. No new content.
- **Behavioral passive** — one always-on behavior, not a number. E.g. Coalition factories repair the base; Syndicate overkill carries to the next target.
- **Exclusive node/defense** — 1–2 unique unlocks. Most content-cost; do last.

Keep factions orthogonal — they tilt the opening, not dictate the build.

Open: count at launch; minor run-shaper vs full class; exclusives per faction; interaction with curses/pacts.

---

## Meta progression

Per DESIGN.md: progression via skill, not F2P grind or pay-to-skip. Meta unlocks expand *options*, not raw power — early runs are never deliberately gimped to sell power back. The two anchors:

### Content unlocks — adds breadth
The meta currency buys *more game*, making future runs richer rather than easier:
- New defense types
- New tech-tree branches / nodes
- New enemy types entering the pool
- New curses/pacts and wave archetypes
- New opening conditions and starting-board configs — feeds the anti-rote system directly
- New player factions

A player 50 runs in draws from a wider pool, not bigger numbers.

### Challenge ladder — progression as mastery
StS ascension-style. Opt into harder runs that yield better meta rewards. Getting better at the game, not stronger in it. Fits the skill-not-grind principle and gives long-term players a reason to climb.

### Minor run-shapers
Small starting bonuses only — a few starting tree points, small starting Material. Shape the opening, never trivialize it.

### Meta currency
Achievement-style unlocks preferred — you unlock by *doing* things, e.g. "beat L10 with a pure-energy build," "kill each enemy type N times." Unlocking by accomplishment rather than accumulating a grind currency keeps it skill-driven. Optional fallback: a fraction of leftover Cores converts on run-end.

Open: pure-achievement vs. a convertible meta currency, and how aggressively content gates behind it.

---

## Scale targets — placeholders
- **Placement tiles by endgame:** ~12–16 across the three layers.
- **Items built per run:** ~15–20 counting merges and replacements.
- **Pacing:** ~1–2 new placements per level, slowing as tiles fill.
- Tiles are a real constraint, so eco buildings trade space against defense.

---

## Open questions
1. Primary currency name: **Material** vs. Materiel / Production / Alloy.
2. Core drop rate — how scarce should build-defining choices be?
3. Adjacency auras: range/stack upgrade design; any authored pair-specific combos?
4. Aim-nudging — which defenses get it, and is it worth the UI cost on mobile?
5. Tile counts per layer — confirm the 12–16 budget against playtest feel.
6. Rare defense delivery — Core purchase, gamba-only, or both?
7. Hex board ↔ three-layer mapping — hexes in the ground band only, or spanning layers?
