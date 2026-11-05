---
name: game-feel
description: Diagnose and tune the responsiveness and sensory feedback of a playable game mechanic, or specify its initial feel targets. Use for movement, impacts, timing, and moment-to-moment polish.
---

# Game feel

Identify the core action and intended sensation (e.g. taut, weighty, elastic).
Inspect the existing controls and implementation when available. Fix response
and legibility before layering effects; select only feedback that serves the
mechanic. With no playable build, deliver hypotheses and a tuning plan.

## Tuning levers

| Lever | Actionable guidance |
| --- | --- |
| Input response | Acknowledge touch immediately; measure touch-to-visible response on device. Tune dead zones, drag mapping, buffering, and cancel behavior to preserve intent. |
| Acceleration/deceleration | Expose time-to-speed, braking, friction, and turning response separately. Compare precise stopping with momentum; keep behavior consistent across frame rates. |
| Animation timing | Separate windup, contact, and recovery; align the contact pose with the actual event. Keep recovery interruptible when the rules permit. |
| Anticipation | Telegraph hazards and committed actions clearly; do not delay basic input acknowledgment for a windup. |
| Hit-stop | Briefly emphasize important contact; start at zero and increase in small millisecond steps. Define what pauses, preserve input, and avoid repeated freezes. |
| Camera feedback | Use directional impulses and quick settling to communicate force; cap displacement and keep targets readable. Provide reduced-motion behavior. |
| Sound | Align transients with events; vary pitch/volume modestly and limit overlapping voices. Core information must remain clear when muted. |
| Particles | Show direction, force, or success; cap count and lifetime. Keep the player, hazards, and touch targets unobscured. |
| Deformation | Use squash/stretch or recoil to show weight and force; keep silhouettes readable and collision boundaries understandable. |
| Haptics | Reserve distinct patterns for meaningful events; avoid continuous buzzing, respect platform/user settings, and test on hardware. |

## Tune with evidence

1. Establish a repeatable scene and baseline recording. Expose relevant values
   with units (milliseconds, distance, speed); record original values.
2. State a hypothesis and change one lever at a time. Compare A/B extremes,
   then narrow the range. Verify normal play and rapid/repeated input.
3. Test on the target phone at representative frame rates, with sound/haptics
   off and reduced motion enabled. Check comfort, latency, readability, and
   performance; inspect input handling after pauses or interrupted gestures.
4. Keep only changes that improve control or communicate the intended sensation.
   Retest the combined effects; individually pleasing effects can become noisy.

Deliver a compact **event → intended sensation → parameter/current/proposed
value → observed result** table, the highest-impact next adjustment, and any
untested assumptions. If changing code, follow the project's conventions and
report what was actually played or measured. Do not present universal timing
presets as validated values for this game.

## Missed or ambiguous action inputs

For intermittent input reports, trace press, hold, release, buffering, eligibility,
consumption and final velocity/action state. An accepted action can still feel
ignored if a later state overwrites it or a release reduces it to negligible motion.
Test ordered rapid edges, direction changes, landing buffers, conflicting actions,
hit-stop, pause and respawn. Preserve event order when combining event callbacks
with frame polling; reset stale intent without discarding a fresh post-reset press.
Compare short and held actions at representative physics rates. Report measured
height, latency or distance, not only that an animation changed. Borrow principles
from reference controllers only after checking their state transitions and bugs.

When a user requests scored critique, define the rubric before rescoring. Keep
independent critics independent; passing tests cannot establish subjective fun or
commercial visual quality. Iterate on concrete blockers and record remaining
untested conditions. Do not raise a score merely to meet a requested threshold.

Keep visual staging separate from action-only playtests. If editor/runtime tools
share files, ports, input injection or save paths across instances, isolate test
processes before running them concurrently. A screenshot setup that changes
position, health or encounter state invalidates an overlapping gameplay run;
discard the affected evidence and repeat it without intervention.

## Focused references

When diagnosing feedback or camera behavior, read
[the compendium](references/compendium.md). Select only the relevant entries;
use their suggested experiments to inform this task, not to expand its scope.
