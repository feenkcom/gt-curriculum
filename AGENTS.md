# gt-curriculum — Agent Notes

## Mission
- Build a newcomer-friendly Glamorous Toolkit (GT) curriculum tied to **feenkcom/gtoolkit#4831**.
- Deliverable types:
  1. Teaching-unit description pages (lives in this repo).
  2. Book/tutorial content (checked into `feenkcom/gtoolkit`, often sourced from Lepiter pages).
  3. Demo/exercise code (migrated to `feenkcom/gtoolkit-demos` or related repos).
- Every commit touching this effort must reference `feenkcom/gtoolkit#4831` in the message (e.g., `Refs feenkcom/gtoolkit#4831`).

## Current Knowledge & Assets
- **Teaching Unit Outlines** (`docs/teaching-units-outline.md` in the `codex` repo) define five starter units:
  1. Bootstrap my repo with Pure Git.
  2. Turn Lepiter notes into publishable DITA.
  3. Document a tool with teaching notes.
  4. From script to reusable demo.
  5. Problem-driven onboarding sprint.
  Each outline covers learner intent, storyline, candidate documentation, demo ideas, and possible assessments.
- **Pure Git documentation (codex repo, `docs/pure-git/`)** already contains:
  - Concept topics (overview, environment setup, on-disk repos, cloning remotes, exploring objects, commit anatomy).
  - Task topics (clone a remote; inspect commit changes).
  - `pure-git.ditamap` + generated HTML under `docs/pure-git/out/`.
- **Lepiter ⇄ DITA Round Trip concept** (markdown + FedWiki page) explains how to map Lepiter snippets to DITA topics via a manifest, maintaining bidirectional traceability.

> These files currently reside in `/Users/rgb/workspace/codex`. Copy or adapt them as needed inside `gt-curriculum` once the structure here solidifies.

## Process Guidelines
1. **Teaching Unit Lifecycle**
   - Start with the outline; expand into a detailed plan referencing concrete GT Book pages/snippets.
   - Identify new Lepiter material or DITA conversions required.
   - Specify demos/exercises and ensure their code lands in `gtoolkit-demos` (with README context).
2. **Documentation Workflow**
   - Author content in Lepiter when possible, export to DITA using the snippet manifest strategy, then check in both source (Lepiter) and rendered DITA/HTML.
   - For Pure Git-like chapters, maintain both concept and task topics; tasks should include prerequisite/context/steps/step results per DITA spec.
   - When creating new context pages or teaching units, draft the FedWiki page first (under `~/.wiki/wiki.ralfbarkow.ch/pages`). Treat Lepiter pages as managed by the GT image.
3. **Cross-repo Coordination**
   - Teaching narratives live here.
   - Core book/tutorial updates happen in `feenkcom/gtoolkit` (cite #4831).
   - Demos belong in `feenkcom/gtoolkit-demos` (or other suites) with explicit links back to the teaching-unit docs.
4. **Assessment & Feedback**
   - Each unit should suggest lightweight assessments (e.g., screenshots, report template, peer-review checklist) to ensure newcomers actively explore GT.
5. **Metadata & Traceability**
   - When converting Lepiter → DITA, assign deterministic IDs (`lepiter-{pageSlug}-{snippetUUID}`) and keep them in a manifest (planned file: `docs/lepiter-dita-manifest.json`).
   - Embed those IDs inside DITA topics so changes can round-trip.

### Style Notes
- Per Oscar Nierstrasz, GT Book titles use sentence case: capitalize only the first word and proper nouns. Use judgement when labeling domain concepts such as “Memory Game” or “Moldable Development,” and cross-check the source text if unsure whether the phrase is treated as a proper noun.

## Next Steps
- Port the existing documents from `codex` into this repo (or reference them directly) so this project can stand alone.
- For each outlined teaching unit:
  1. Attach specific GT Book sections/snippets.
  2. List required new Lepiter/DITA pages.
  3. Enumerate demo code tasks.
  4. Define assessment artifacts.
- Automate the Lepiter export → DITA conversion → HTML build pipeline as part of this repo (reuse the `pure-git` example as a template).
- Coordinate with `gtoolkit`/`gtoolkit-demos` maintainers when moving tutorials or demos; ensure PRs cite `feenkcom/gtoolkit#4831`.

Keep this file updated as the curriculum evolves so future agents have a single source of context.
