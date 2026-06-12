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

### Hex grid
Defenses sit on **2 rows of hexes** — TFT's board adapted, much softer: placement is small optimizations, not a primary skill axis. Hex adjacency (up to 6 neighbors) opens the possibility of **3-way combines**. 2 rows × ~6–8 hexes lines up with the 12–16 tile scale target.

Open: how the hex board maps onto the three layers — hexes in the ground band with orbital/deep as separate slots, or rows spanning layers?

---

## Battle behavior

- **Build/place is live, mid-battle.** Spending/placement at Resupply likely allowed too.
- Defenses act **autonomously** — no per-shot micro.
- Player sets **targeting priority** per defense where it fits: closest / furthest / specific spot.
- Delivery types: **projectiles** (varied trajectories and effects), **beams**, **drones** (launched, fly around).
- Defenses are **stationary** — no movement unless a compelling design reason shows up.
- Enemy AI and spawn mechanics: deferred.

---

## Combine mechanic

Place two defenses adjacent to merge them. Frees the second tile — the core benefit on a space-tight screen.

- **Same + same:** merges into one tile at ~1.8× output, or a tier-up variant with a new trait. The win is reclaiming a tile, not raw doubling, so merging is a spatial play, not an auto-yes.
- **Different + different:** combo output. Laser + drone launcher → drones that fire lasers. Each pair is a hand-authored result.

Open: how many combo pairs to author, whether merges are reversible, whether hex-enabled **3-way merges** exist.

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

### Curse / pact system — the StS-replacement variety engine
After certain levels, offer 2–3 bidirectional trades. The player steers their own difficulty and economy, which forces different builds run to run.
- "+30% enemy armor, but Cores +1/wave"
- "double enemy speed, but Material income +50%"
- "enemies explode on death, but defense range +20%"

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
3. Combine: how many authored combo pairs? Reversible merges?
4. Aim-nudging — which defenses get it, and is it worth the UI cost on mobile?
5. Tile counts per layer — confirm the 12–16 budget against playtest feel.
6. Rare defense delivery — Core purchase, gamba-only, or both?
7. Hex board ↔ three-layer mapping — hexes in the ground band only, or spanning layers?
