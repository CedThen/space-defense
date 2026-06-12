# ORBITAL (working title) — Design Doc

A vertical, sci-fi, roguelite tower defense for iOS. Single source of truth — current decisions only, plus open questions at the end.

---

## Concept

Vertical-screen base defense. Enemies pour downward; you build/upgrade stationary defenses to stop them reaching the bottom. Run-based roguelite: reach the end boss after ~10 levels. Structure modeled on Slay the Spire. Theme is sci-fi/space.

**Terminology:** the units are **defenses**, not towers.

**Genre:** roguelite tower defense.

Failure should most often come from misallocated resources, then: didn't adapt to enemy composition, poor coverage, bad economy timing.

---

## The five systems

Everything in the game belongs to one of these. Economy is the bloodstream across all five, not a system of its own.

1. **Meta progression** — out-of-game, permanent. Unlocks breadth (tech-tree nodes, defenses, races, curses), never raw power. Passed into a run as data at run start.
2. **Tech tree** — in-run. Buys *capabilities*: the right to build defense types, defense techs, abilities/CDs. Chosen, always-on once bought.
3. **Per-defense upgrades** — in-run. Scales one specific placed defense. Rule vs. the tree: **tree sells behaviors, upgrades sell numbers** — the tree never sells +X%, upgrades never grant behaviors.
4. **Resupply** — between levels, the decision hub: repair/heal, gamba, shop (TBD), interest tick, powers slotting (panel + bag), enemy curse pick.
5. **Battle & placement** — the fight: autonomous defenses on a hex grid, combine, targeting priorities. **Placement is live, mid-battle**; Resupply spending/placement likely allowed too. Details in [ECONOMY_AND_CONTENT.md](ECONOMY_AND_CONTENT.md).

Deferred for later: enemy AI, spawn mechanics.

---

## Core gameplay loop

Per level: survive the wave, then on clear earn currency to spend before the next level. The central decision is an **economy of opportunity cost over time** — spend now to survive vs. invest to scale later. Spending compounds: an early economy investment pays off across the whole run, while over-spending on immediate power leaves you weak later. This is where Slay the Spire's compounding-decisions feeling comes from (the eco curve, not a map). ~10 levels keeps the snowball arc readable. Choices and purchases persist between levels within a run.

### Spend categories
- **Power:** defenses and upgrades. Immediate survival and damage.
- **Economy/scaling:** invest now for more income later. The greed play.
- **Defense:** more of a gimmick than a core pillar (DPS is king in this genre), but should enable alternative strategies via things like defense drones or hardened shields. To explore later.

### Run structure beats
- **Level 5 miniboss** (halfway): rewards a stronger buff on clear.
- **Carryover money:** currency saved at the end of a level carries into the next, and serves as the gamba currency in the post-level phase. Spending vs. saving is itself part of the eco decision.

### Reward & build system
Two reward textures, deliberately different — both exist:
- **Tech tree:** visible; player techs toward what they want. *Chosen permanents* — always-on once bought, no slotting.
- **Powers (slot panel + bag):** *random drops* — offered as end-of-level rewards; slot what's usable now into a limited panel at Resupply, bag the rest. Bag has limited capacity.
- **Gamba option:** player can risk points/resources to reroll or gamble for a high-roll bonus.
- Keep systems legible and mobile-friendly over deep crafting.

### Forced diversity
Levels roll different tiers/types of enemies, so a build with no answer to a rolled tier struggles.

### Player-chosen curses/twists
After certain levels, the player picks an escalating modifier to take on (e.g. +enemy armor, ramping enemy damage).

---

## Enemy & strategy ideas (early)
- **Loiter-drone:** starts slow at the top, then rapidly accelerates toward the bottom.
- **Carrier:** sits at medium distance spawning small droppers, then retreats to the top to regenerate before returning.
- More enemy tiers TBD: armor, swarm, shield, fast, etc.
- **Defense-enabling options** to explore: defense drones, hardened shields — ways to make non-DPS strategies viable.

---

## Meta progression (between runs)
Normal progression curve via play and skill, not F2P grind or pay-to-skip.
- **Unlock skill-tree areas** for future runs.
- **Small starting bonuses:** minor run-shapers like a few starting tree points or small gold.
- **Run history & high scores:** Home surfaces previous runs and bests.

---

## Open questions
1. Mid-battle placement is decided (live, continuous). Confirm: is spending/placement also allowed at Resupply? (Leaning yes.)
2. Slot panel specifics — how many slots, bag size, are slotted bonuses permanent for the run or swappable?
3. Gamba design — what's the risk currency, and what's the reward curve?
4. Enemy tiers — define the actual tier list and how a level rolls them.
5. Curse menu — the actual list of modifiers.
6. Tech tree shape — branches, mutual exclusivity, respec?
7. Do enemies collide with each other, or only get detected and reach the base? (Open field is decided — no lanes.)
8. Level length and run length — ~10 levels chosen; confirm per-level length and total run time target.
9. How steep is the eco scaling curve — how fast does an early investment pay back? (Currencies decided: Material + Alien Cores.)
