---
name: interface-cheat-sheet
description: Interface craft rules (UI, animation, typography, colors, accessibility, layout, UI writing) distilled from interfaces.dev/cheat-sheet. Use whenever writing, reviewing, or refactoring frontend code, CSS, Tailwind classes, design tokens, components, forms, buttons, links, empty states, or any user-facing copy in a UI. Also use when the user says "interface cheat sheet", "interfaces.dev", "polish this UI", "check the craft", or "make this feel native".
---

# Interface Cheat Sheet

Source: https://interfaces.dev/cheat-sheet (last synced 2026-08-21). Apply these rules when you write or review any UI. Where a rule conflicts with a house rule below, the house rule wins.

## House overrides

- **No em dash, ever** in copy (global engineering rules). The cheat sheet allows one for asides; we do not. Curly quotes, en dash for ranges, and the single ellipsis character stay allowed.
- **No gradients** unless the project's design system explicitly uses them. The `in oklab` / `in oklch` rule only applies if a gradient already exists.
- All user-facing copy goes through i18n keys. Fix the wording in the translation files, never inline.

## User Interface

- Use concentric border radius on nested elements (inner radius = outer radius minus the padding).
- Align for optical alignment, not geometric alignment.
- Give images a `1px` outline, offset by `-1px`: black at `8%` opacity in light mode, white at `8%` in dark mode.

## Animation

- Never use `transition: all` (Tailwind `transition-all`), name the exact properties that change instead.
- Slightly scale down buttons to a value between `0.95` and `0.98` when pressed with `transition: scale 200ms ease-out`.
- Cross-fade icons when they swap. The entering icon scales `0.25` → `1`, opacity `0` → `1` and blur `4px` → `0px`. The exiting one reverses the same animation.
- Use CSS transitions for interactions, because they can be interrupted. Use keyframes for sequences that only run once.
- Disable all transitions when changing theme from light to dark and vice versa.
- Use `will-change` only for properties that are actually changing: `transform`, `opacity` and `filter`.
- When an element shifts randomly by 1-2px when animating, especially in Safari on iOS, add `will-change: transform` to the element.
- When animating entrance, stagger elements by group or by individual elements.
- Don't animate high-frequency interactions such as color change of an item on hover in a list.

## Typography

- Always use `.woff2` on the web, never `.ttf` or `.otf`.
- Use `font-variant-numeric: tabular-nums` (Tailwind `tabular-nums`) on every value that changes and in tables: timers, counters, prices, data columns. Skip if already monospace.
- Cap long-form text at 60–75 characters per line.
- Use `text-wrap: balance` on headings, `text-wrap: pretty` on descriptions, neither in long-form text.
- Use `overflow-wrap: break-word` where long words, links or IDs can escape; `white-space: nowrap` on labels and badges.
- `-webkit-font-smoothing: antialiased` and `-moz-osx-font-smoothing: grayscale` once on the root, never per component.
- Store copy in natural case and control the presentation with `text-transform`.
- Smart punctuation: curly quotes, an en dash for ranges, the single ellipsis character. (No em dash, see house overrides.)
- `text-underline-position: from-font` with `text-decoration-skip-ink: auto`, so underlines clear the descenders.
- Truncated text keeps the full value reachable in a tooltip or an expanded view.

## Colors

- Every step in a color palette should have a purpose: page background, component hover, border, solid fill, body text. Don't add steps that nothing uses.
- Components should use semantic tokens (`--color-text-secondary`), never primitives (`--blue-500`). The primitive is the raw value, the token is how the value is used.
- Never name a token for its appearance or its first use: `--color-accent-solid`, not `--color-blue-button` or `--color-sidebar-gray`.
- Reserve `accent` for the brand color so `primary` never means both the brand and the main body text.
- Don't reuse a token from another role just because it's the right color. Add a token for the new role instead.
- Measure contrast against the background the element actually renders on, not the page background.
- Dark mode palette is not the light palette reversed.
- Pick one theme switching mechanism: `prefers-color-scheme` or a `.dark` class, and use it for every token.
- If a gradient exists, you can define its interpolation space: `in oklab` for even brightness, `in oklch` for more vivid middle tones, or neither (sRGB, muted midpoint).

## Accessibility

- Use semantically correct native elements: `<button>` for buttons, `<a>` for links, never a plain `<div>` when a native element exists.
- Style `:focus-visible`; never `outline: none` (Tailwind `outline-none`) without a replacement.
- Only use `tabindex="0"` and `tabindex="-1"`. Positive values break the natural tab order.
- Give icon-only buttons a descriptive `aria-label` and never put `aria-hidden="true"` on a focusable element.
- Write alt text by purpose: `alt="Search"` on a search button, not `alt="magnifying glass"`. Decorative images get `alt=""`.
- Give every input a real `<label>`, `type` and `inputmode`.
- Never block paste; people paste passwords and one-time codes.
- A tooltip on a `disabled` control never opens for keyboard or touch. Put the explanation in visible text next to it, or use `aria-disabled="true"` to keep the control focusable.
- Keep submit enabled until the request starts, then validate on submit: `aria-invalid="true"`, `aria-describedby` pointing at the error, focus on the first invalid field.
- Use at least a `24x24px` hit-area, `44x44px` on touch and `40x40px` on desktop where possible. Extended hit areas never overlap.
- Use `pointer-events: none` on decorative elements like glows so they never swallow clicks meant for a control.
- Put hover styling behind `@media (hover: hover)`. On touch, `:hover` sticks after a tap and looks selected. (Tailwind v4 does this by default; v3 needs the `hoverOnlyWhenSupported` future flag.)
- Wrap motion in `@media (prefers-reduced-motion: no-preference)` so it only plays for people who haven't asked to reduce it.
- Use `role="status"` for routine updates and `role="alert"` only for urgent errors.
- For status changes add an icon, a label or an underline. Status changes never use color alone.
- The skip-to-content link is the first focusable element; add `scroll-margin-top` on anchored headings.

## Layout

- The gap between groups is at least twice the gap inside one: `8px` within, `16px`+ between.
- Use logical properties like `margin-inline-start` and `padding-inline-end` (Tailwind `ms-` / `pe-`) instead of left and right.
- Don't use fixed widths or heights on text containers.

## Writing

- Start button labels with a verb: "Save draft" or "Delete project", never "OK!" or a bare "Yes".
- Repeat the consequence in confirmation buttons: "Delete project" next to "Cancel".
- Pick one word per flow and keep it for every step: "Continue" or "Next", never both.
- Describe the destination in link text: "Read docs", never "Click here".
- Capitalize buttons, headings and labels the same way everywhere. Sentence case is the safer default.
- Label toggles with the state they turn on: "Send read receipts", never "Disable read receipts".
- Orient the reader in empty states and offer one next action instead of "No results".
- Address the reader as "you", not "the user".

## Review procedure

When asked to apply or check this cheat sheet on a codebase:

1. Grep the mechanical violations first, they are cheap and unambiguous:
   - `transition-all`, `transition: all`
   - `outline-none`, `outline: none` without a `focus-visible` replacement next to it
   - `tabIndex={[1-9]`, `tabindex="[1-9]`
   - `.ttf`, `.otf` font loads
   - `onClick` on `div` / `span` without `role` and key handling
   - `<button>` with only an icon child and no `aria-label`
   - `font-smoothing` declared outside the root stylesheet
   - `<input type="email|tel|number|url|search">` without `inputMode`
   - copy: "OK", "Oui", "Yes", "Click here", "Cliquez ici", "Disable …" as a toggle label, "No results" / "Aucun résultat" with no next action
2. Add once, globally, in the root stylesheet if absent: font smoothing on the root, `h1–h3 { text-wrap: balance }`, a `prefers-reduced-motion: reduce` block, `scroll-margin-top` on `[id]` headings.
3. Fix targeted items by judgment: `tabular-nums` on prices, timers, counters and data columns; `aria-label` on icon buttons; `role="status"` on live regions.
4. Leave the structural items (semantic tokens, logical properties everywhere, concentric radii) as a list for the user unless asked to refactor.
5. Run lint and type-check before committing.
