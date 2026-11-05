---
name: game-art-director
description: Define a coherent visual direction and reusable art bible for a game, including shape, color, motion, materials, and UI. Use before asset production or when resolving inconsistent game artwork.
---

# Art director

Start from the core mechanic, intended emotion, target phone/orientation, and
production budget. Respect established assets and explicit visual preferences.
Choose a coherent direction; make the playable state readable before adding
decoration. Deliver art direction, not generated assets, unless requested.

## Named styles and reference research

Treat the user's named games, artists, and style corrections as visual constraints,
not just mood keywords. Before committing a direction or generating assets, inspect
representative gameplay images from the named references. Prefer official screenshots
or press kits over covers, promotional paintings, fan art, or memory. For animation
claims, inspect footage or animation frames. Keep research focused on the properties
that matter to this request; do not expand it into a general mood-board survey.

Record a compact reference breakdown in the project's art notes: source link, what
was actually viewed, properties to retain, properties to exclude, and the concrete
production decision each observation supports. Compare silhouette/proportions,
on-screen character scale, pixel-cluster size, shading and texture density, palette
and value hierarchy, edge treatment, camera, and effect shapes. Distinguish observed
properties from your proposed adaptation. If a reference cannot be inspected, say
so and label any interpretation provisional rather than claiming a visual match.

When references differ, assign them roles rather than blending them indiscriminately
(for example, one for sprite economy and another for side-view staging). The user's
stated preference determines priority. Interpret words such as "simpler" against
the references: fewer internal shapes, flatter shading, less texture, or smaller
sprites are different decisions. Ask only when a material ambiguity remains.

Translate the comparison into positive, observable constraints in the art bible and
asset prompts. A generic "pixel art" tag or a list of things to avoid is insufficient.
For revisions, state what missed the target and which properties will change; do not
preserve rejected detail merely because it appeared in your earlier proposal. Use
prior generated images only for the properties that should survive the correction.

Before expanding an asset family, compare a representative result to the selected
references at intended gameplay scale. Judge style fidelity separately from general
attractiveness and readability; an attractive image can still miss the brief. If it
misses the requested traits, make a focused revision before extending that direction.
Keep actual-device, grayscale, and motion checks pending until performed.


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
