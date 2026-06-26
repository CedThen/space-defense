# Plan

## MVP

1. build the main battle scene
    - placing defenses onto the field - lets do at least 3
    - defenses can target enemies and fire projectiles
    - enemies spawn and move towards the base
    - battle sounds - on structure firing, on enemy hit/death?
    - in game dev tools
        - show meta progression perks
        - restart level
        - give gold
        - clear enemies
        - save/load specific points
2. battle scene UI
    - gold values, floating damage numbers, hp bars, etc.
    - menu for buying and placing defenses
    - tech tree placeholder
    - pause menu
    - dev menu
3. Resupply scene
    - menu and UI for options
    - dev options
3. home scene
    - enter battles
    - meta progression placeholders

## Ideas and polish
1. Turret part needs to animate + rotate towards the target, projectiles come out from the turret at that angle
2. hex cell glow + highlight + minor animations
3. enemies need some animation upon getting hit. pbly doesn't need sound. projectiles also need animation on hit, and sound on firing


## Issues tracker
1. RunState is a global autoload - do we need to add containment so its not accidentally mutated or called when its not needed?
2. Maybe a better solution for enemy pathing downwards then stopping at attack range - they have an area2d to detect when they are in range of the base? or is this too resource intensive (claude says bad idea)
3. Projectiles.gd seems a little flimsy - needs improvements, currently handling all projectiles
4. an unaffordable structure in the buildmenu should still have hover highlighting enabled, just not clickable

## Tech Tree Ideas
1. Improved targeting - projectiles lead the target better, missiles retarget, etc
2. Faster projectiles

### Current Task

- create battle scene
    - ✅ earth backdrop 
    - ✅ hex grid for the defense placements
    - ✅ base appearance
    - ✅ wave spawner

- Scaffold defenses and turrets
    - ✅ hex grid
    - menu to place defenses
    - ✅structures fire at enemies

- Enemies
    - ✅ enemy definition
    - ✅ script - basic movement and hp
    - ✅ move toward base
