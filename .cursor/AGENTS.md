# Global Engineering Principles

These principles apply to every project. Consult them when designing, coding, or reviewing. Project-specific rules (workspace `AGENTS.md`, `.cursor/rules/`, `CLAUDE.md`) override these where they conflict.

---

## 1. Codebase-first

Before writing a helper, formatter, coercion, color, or interaction primitive: **search the codebase for prior art**. Prefer joining an existing convention over introducing a competing one.

- When you find two conventions, count callsites. The dominant one wins close calls; the outlier is not "convention".
- Look for utilities in `lib/utils/`, `lib/hooks/`, shared component folders, and sibling components before writing new ones.
- Match the neighbor. The nearest sibling component on the same page is the strongest style precedent.

## 2. State management

- **Forms**: use the project's form library (RHF, react-final-form, etc.) idiomatically — not parallel `useState`. Use `useFieldArray` for repeatable rows, `useController` when you need imperative access, `useWatch` for cross-field reactivity.
- **Avoid `useEffect` for derived or synchronizable state.** If you're syncing one piece of state to another, try first: hoist the dependency up so it's available synchronously, use `key` to remount on identity change, or `useState(() => initial)` at mount.
- **Discriminated unions are good, but not always needed.** `T | null` often says the same thing as `{ kind: "closed" } | { kind: "open"; ... }`. Reach for the tagged union only when there's asymmetric data per variant.
- **`key` prop is a remount hammer.** Use it to reset state when identity changes (editing vs. creating).

## 3. Types and boundaries

- **Never duplicate generated types locally.** Import from the generated client. Local duplicates drift.
- **Prefer distinct callbacks over union-typed callbacks.** `onCreate` + `onUpdate` beats one `onSave` with a union payload and optional id.
- **Strip redundant optionality.** `X | null | undefined` → `X | null` if callers always set it.
- **Coerce at the boundary, not throughout the UI.** Form values are usually strings — do type coercion once during serialization; validate parseability once in schema validation; do not scatter `Number()` / `=== "true"` across editors.
- **Restrict input shape at the source.** A `<Select>` for boolean removes the possibility of `"maybe"`. `type="number"` blocks alphabetic input. Validation becomes the belt to the UI's suspenders, not the only line of defense.

## 4. Component ownership

- **The component that owns the domain data should decide whether to render** its dependent UI.
- **Wrappers earn their keep with logic.** A single-case `switch` with no meaningful default is indirection for nothing. A wrapper with a real default branch (a "not supported" state, permission gating, etc.) is a real component.
- **Prop plumbing: pass strings, not enums, when downstream only needs display.** Compute display strings once at the top; child components don't need to know about internal enums or how to format them.

## 5. UI/UX for non-technical users

- **Audit every user-facing string for jargon.** Words like "mapping", "source", "target", "composition", "operation", "template" often leak from developer vocabulary and mean nothing to the actual user.
- **Prefer concrete over abstract when the abstraction has one instance.** "In Filevine" > "on the external platform". Genericize *when* a second case arrives, not preemptively.
- **Error messages must reference what the user sees in the UI.** If the input label is "When record has..." and the error says "duplicate lookup key", the user has no chain to follow. Match the label.
- **Consistency in copy is UX.** Two buttons doing the same thing must share a label. Empty-state CTA and header CTA read identically.
- **Show validation errors inline, close to the fix.** Per-field paths beat a single global toast.

## 6. Interaction and layout

- **Zombie affordances are bugs.** If a button looks pressable, it must be. Distinguish disabled, destructive, and muted visually.
- **Loading states must not collapse layout.** Keep chrome (header, description, actions) visible; only the data-dependent body changes. Skeletons that match eventual shape prevent reflow, but a shape-preserving spinner is often enough — match the codebase's loading convention.
- **Combobox with search > cascading selects** for pick-from-many. Same click count as a dropdown, adds type-ahead, scales to hundreds of items, and group headings preserve context.
- **Radix nesting gotchas**: a `Popover` inside a `Dialog` needs `modal` prop, or the outer Dialog swallows scroll/pointer events. `FormControl` + Radix `Slot` cannot cross portal boundaries — drop the wrapper or wire IDs manually.
- **CSS state styling**: for a child to react to a parent's focus/hover state, use `group` on the parent + `group-focus:` / `group-hover:` on the child. Relying on `color` inheritance through `opacity` is fragile.

## 7. Feedback and iteration

- **Verify third-party findings before fixing.** When a bot or reviewer flags something, read the actual runtime path (backend coercion rules, downstream consumers) to confirm the bug is real and to size its blast radius.
- **Fix the underlying UX cause, not just the symptom.** If a serializer emits bad data because the input allows garbage, tighten the input — don't just coerce more defensively.
- **When users push back, hear the *why*, not the *what*.** "I don't want a useEffect" is about not clobbering state or sync loops. Reframe the solution space around the concern, not the literal ask.
- **Present tradeoffs when honestly unsure; don't fake certainty.** Lay out options with real pros/cons and let the user pick, especially for reversible UX decisions.

## 8. Testing

- **Unit-test pure functions in isolation.** Serialization round-trips, validation schemas, coercion helpers — each catches entire bug classes.
- **Test the observable contract**, not internal structure. Assert on error paths + message substrings, not implementation details.
- **Update tests when copy changes.** Tests that assert on user-facing strings are copy documentation; updating them enforces follow-through.

## 9. Comments and docstrings

**Only strictly necessary comments are allowed.** The default is no comment. If you are unsure whether a comment is necessary, it is not. Slop comments are treated as bugs. This applies equally to docstrings.

- **Allowed only for**: external-system quirks the code works around, non-obvious invariants or constraints that would otherwise look like a bug, magic values, and TODOs with a concrete condition or ticket. `// Character class prevents backtracking across nested {{ }}` is signal; `// increment counter` is noise.
- **One line, two at most.** Docstrings are a one-sentence summary, plus at most one short paragraph for a contract the caller must know (raises, idempotency, None semantics).
- **Never**: restate the code, name, or type; narrate the change or its history ("added", "now", "previously", "mirrors X"); justify why the change is correct (that belongs in the PR description); write numbered steps or design essays; comment self-explanatory fields; walk through tests; use end-of-line comments; leave commented-out code.
- **When editing**: delete comments your change makes stale, trim nearby slop instead of matching it, and before finishing re-read every comment you added and cut each one that isn't strictly necessary.

## 10. Meta: know when to stop

- **YAGNI when the second case is speculative.** Hardcode concrete strings, enums, and paths until there's evidence of a second use. Genericize on demand.
- **Reversibility matters.** For easily-reversible decisions (copy, small components, prop shapes), just pick and iterate. For hard-to-reverse ones (data model, API shape, schema), slow down and ask.
- **When you extract an abstraction, watch for the "single-case wrapper" smell** — but also respect that a wrapper can be valuable as a marker for future extension, even when its body is thin.

---

**One-line distillation**: *look before you write, prefer inherent tools over escape hatches, coerce at boundaries, write for the person who'll use it, and let established codebase conventions win close calls.*
