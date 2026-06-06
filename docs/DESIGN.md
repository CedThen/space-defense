# ORBITAL (working title) — Design Doc

A vertical, sci-fi, roguelite tower defense for iOS. Single source of truth — current decisions only, plus open questions at the end.

---

## Concept

Vertical-screen base defense. Enemies pour downward; you build/upgrade stationary towers to stop them reaching the bottom. Run-based roguelite: reach the end boss after ~10 levels. Structure modeled on Slay the Spire. Theme is sci-fi/space.

**Genre:** roguelite tower defense.

Failure should most often come from misallocated resources, then: didn't adapt to enemy composition, poor coverage, bad economy timing.

---

## Core gameplay loop

Per level: survive the wave, then on clear earn currency to spend before the next level. The central decision is an **economy of opportunity cost over time** — spend now to survive vs. invest to scale later. Spending compounds: an early economy investment pays off across the whole run, while over-spending on immediate power leaves you weak later. This is where Slay the Spire's compounding-decisions feeling comes from (the eco curve, not a map). ~10 levels keeps the snowball arc readable. Choices and purchases persist between levels within a run.

### Spend categories
- **Power:** towers and upgrades. Immediate survival and damage.
- **Economy/scaling:** invest now for more income later. The greed play.
- **Defense:** more of a gimmick than a core pillar (DPS is king in this genre), but should enable alternative strategies via things like defense drones or hardened shields. To explore later.

### Run structure beats
- **Level 5 miniboss** (halfway): rewards a stronger buff on clear.
- **Carryover money:** currency saved at the end of a level carries into the next, and serves as the gamba currency in the post-level phase. Spending vs. saving is itself part of the eco decision.

### Reward & build system
- **Skill tree:** visible; player techs toward what they want with earned points.
- **Slot panel + bag:** random bonuses/powers are offered; player slots what's usable now into a limited panel, and bags unused ones for later. Bag has limited capacity.
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

---

## Open questions
1. When do decisions happen in a level — continuous, at wave breaks, or only between levels?
2. Slot panel specifics — how many slots, bag size, are slotted bonuses permanent for the run or swappable?
3. Gamba design — what's the risk currency, and what's the reward curve?
4. Enemy tiers — define the actual tier list and how a level rolls them.
5. Curse menu — the actual list of modifiers.
6. Skill tree shape — branches, mutual exclusivity, respec?
7. Lanes vs. open vertical field; do enemies collide with each other or only get detected and reach the base?
8. Level length and run length — ~10 levels chosen; confirm per-level length and total run time target.
9. Economy specifics — is there one currency or separate currencies for power/eco/defense? How steep is the eco scaling curve (how fast does an early investment pay back)?
