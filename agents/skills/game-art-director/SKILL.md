---
name: game-art-director
description: Define a coherent visual direction and reusable art bible for a game, including shape, color, motion, materials, and UI. Use before asset production or when resolving inconsistent game artwork.
---

# Art director

Start from the core mechanic, intended emotion, target phone/orientation, and
production budget. Respect established assets and explicit visual preferences.
Choose a coherent direction; make the playable state readable before adding
decoration. Deliver art direction, not generated assets, unless requested.

## Reusable art bible

Fill this compact format with concrete decisions, not adjectives alone:

| Field | Required decisions |
| --- | --- |
| Visual premise | One sentence connecting the mechanic to a visual metaphor, plus three defining qualities |
| Shape language | Dominant silhouettes, proportions, edge treatment, and distinct rules for player, hazards, goals, and scenery |
| Palette strategy | Named color roles with hex values; background/value hierarchy, accent budget, and state colors supported by shape or symbols |
| Camera/perspective | View angle, projection, framing, scale, depth cues, and what remains visible around the player's thumb |
| Animation style | Posing, easing, rhythm, deformation, transition timing, and how motion communicates mechanical state |
| Texture/material language | Flat or shaded treatment, light direction, surface detail budget, edge/outline rules, and permitted materials |
| UI style | Type hierarchy, icon geometry, panel/button treatment, touch target sizing, safe areas, and contrast priorities |
| Reference keywords | Searchable terms for form, medium, era, lighting, and motion; explain which property each should inform |
| Explicit anti-goals | Specific forbidden shapes, palettes, effects, materials, or UI treatments and why they conflict with the direction |

Separate **invariants** (shared palette roles, perspective, outline rules) from
**allowed variation** (character silhouettes, accent assignment, impact size).
For each representative asset, specify role, silhouette, relative scale,
material/color assignment, animation states, background/transparency, and
export requirements appropriate to the chosen engine. Do not invent fixed
pixel dimensions before the game's display scale is known.

## Consistency check

Describe one gameplay frame and a minimal proof set: player, hazard/goal,
background, one impact, and one UI control. Judge them at actual phone size,
in grayscale, and in motion; check silhouettes, contrast, thumb occlusion,
and whether art reveals the rules. Mark checks as pending until viewed.

End with a short reusable asset brief: **subject + gameplay role + bible
invariants + permitted variation + state/pose + export needs + anti-goals**.
Use references to name visual properties rather than instructing a copy of
another game's identity. If reference images are supplied, explain which
properties to retain and which to reject.

## Focused references

When choosing visual references or checking handheld readability, read
[the compendium](references/compendium.md). Select only the relevant entries;
use their suggested experiments to inform this task, not to expand its scope.
