# Important Rules

**Most important**: a specific repository's own rules take priority over these general ones. These are my rules and how I like to work, but other people see things differently — align with the culture and expectations of the repo you're in rather than following these to the letter. If a repo doesn't have its own rule for a given area, use the rule here to introduce structure.

**Read every rule below as a direct instruction, not a description.** They're written in the imperative on purpose: "Do X" carries the same force as "You MUST do X," without repeating MUST on every line. The only rules that bend are the ones that say so explicitly, with words like "prefer," "if appropriate," or "feel free" — anything phrased as a plain command is not optional.

Every rule keeps a short bold name so you can cite which one drove a decision.

## General

- **Be Agnostic.** Put things where any reasonable agent would find them, not just Claude — use `AGENTS.md`, not `CLAUDE.md`, for repo-visible instructions.
- **Don't Write Code on Questions.** Never react to a question or investigation by implementing a code change implied by the question. It's okay to build tools to investigate further and keep them, and it's okay to make temporary changes to see what something does, but *investigating* a possible solution is separate from *choosing* one.
- **Be Concise.** Say what's needed without being obtuse, both in conversation and in anything you write down.
- **DRY.** Give every idea, decision, or piece of code exactly one home. Reference it from everywhere else instead of copying it, unless the repetition itself serves a purpose.
- **Stay Local.** Keep everything inside the repo. Lean on heavyweight tools that are already installed globally, but don't make a repo depend on external state to function.
- **Self Generalize.** When an instruction is phrased as a general rule about how you should work, write it down in the right document (`AGENTS.md`/`CLAUDE.md` as appropriate) instead of only applying it once.
- **Forget the Irrelevant.** Record only what actually happened or was decided; leave out paths not taken or things discussed but not done, unless asked to keep them. Delete dead code outright, not commented out.
- **Cut Redundant Negatives.** Before writing a rule as "don't do X" or "never Y," check whether the positive form already excludes X/Y once read strictly (per the instruction above). If it does, cut the negative — naming an already-excluded alternative is a recorded rejected branch, the same thing Forget the Irrelevant rules out. Keep a negative only when it's the rule's actual substance, a genuine exception or safety boundary, or it's explaining a real asymmetry.
- **Instructions are Local.** Any directory in the project may have an `AGENTS.md` file, not just the project root. When working in a directory, read and follow the instructions in that directory if they exist, as well as all instructions up the tree to the project root.

## Tool Use

You have access to a wide variety of tools, and you are made much more powerful by the tools you have available. This includes using tools you are given, writing new tools for your future self, and researching whether gaining access to existing tools would be helpful. Tools include MCP server endpoints, shell scripts in the repository, shell scripts stored elsewhere that you have access to, make commands, among others.

- **Tool Index.** Keep track of the tools at your disposal in `AGENTS.md` under a section `Tool Index`. Record the command required to invoke the tool, followed by the circumstances in which you would use the tool.
- **Prioritize Tools.** Treat the tool index as a prioritized list, with higher priority tools nearer to the top. Priority is based on efficiency: tools that save the most work are the highest priority.
- **Write Tools.** When you have to perform a task for which a simplifying tool doesn't exist, consider if the task is likely to be useful in the future. If so, write a tool to implement the task, add an entrypoint to it in `make`, and add it to the index.
- **Use Tools.** If you have a tool that does the same thing as an ad-hoc Bash command, use the tool.

## Git

Git handles history. Don't make code or docs history-aware — that's what `git log`/`git blame` are for.

- **Commit Regularly.** Commit in checkpoints as you work. Make every commit net-better than what was there before it. Make checks pass on every commit that isn't prefixed `WIP`.
- **Self Identify.** Include a signature block on every commit: model used, time taken, tokens used, and validations performed before committing.
- **Git is for History.** Explain decisions and their reasoning in the commit message. Use `git log`/`git blame` to recover past reasoning.

## Coding

- **Maximize Cohesion.** Group code by component/feature/use case, not by type — `auth, favourites, payments`, not `views, factories, models`.
- **Delay Abstraction.** Introduce an abstraction once you know it's needed, not before. Default to the simplest thing that works.
- **Proactively Refactor.** Look for chances to simplify and re-group code for cohesion as you go — don't wait to be asked.
- **Focus on Now.** Code (and comments) should read as though it was written correctly the first time and has no memory of how it got there. It should be impossible to tell from the file which lines were edited most recently.

## Documentation

- **Locality.** Document as close to the point of use as possible: adjacent comments for code, a comment on the function, a file-header comment, inline comments in a config or automation file (a Makefile target, a CI job) explaining its own behavior, a `README.md` per directory, a `README.md` at the repo root. A standalone decisions/rationale log (a `DECISIONS.md`, an ADR directory) is the opposite of this — it separates the reasoning from the thing it explains, so both drift out of sync as soon as either one changes without the other. Explain a technical choice as a comment where the choice was actually made; explain a user-facing one in the README section that describes the behavior it produces. Don't keep a separate log for either. This cuts both ways: a comment sticks to its own layer's concern, so implementation code doesn't explain a detail owned by another layer (which key or button triggers it is a UI concern, not the logic's) and vice versa.
- **Documentation
- **Say It Once.** State a design decision or invariant exactly once, at the place that actually implements it — not again in a summary comment one level up (a file/class header shouldn't pre-narrate what a lower-down comment already explains at the point of use), not again at every call site ("see above" on each one; comment the first, reference it only if truly needed elsewhere), and not duplicated between a code comment and a README describing the same behavior for users. Reference the one place instead of repeating it.
- **Only When Needed.** Write a comment only if it passes this test: "delete the comment. Would a competent reader of this codebase now misread the code, or repeat a mistake someone already made?" If not, leave it deleted. That leaves a narrow set of legitimate comments: a non-obvious constraint, a workaround for an external defect (with a link or issue reference), or a tradeoff whose rejected alternative looks better than it is.
- **Source of Truth.** Give every piece of information exactly one source of truth. Reference it from anywhere else that needs it instead of copying it. A tool's own file (a Makefile, a config schema, a script's `--help`) is usually the source of truth for its own behavior — document it there and have every other doc link to it, not restate it in prose that will drift out of sync the next time that file changes.
- **The Repo Describes Now.** Keep the repo describing its current state only. Delete anything no longer needed, as long as it has history in source control.
- **Concept Indexing.** Maintain an `INDEX.md` at the repo root listing every important *concept* — a reusable subsystem, responsibility, or idea (e.g. "chord/scale theory," "the audio voice engine," "the input model"), not a file, a directory, a test suite, or "how to use this." Before adding an entry, ask: would I want to recognize this as already-solved if I hit the same problem again elsewhere in the repo? If not — it's just where some code happens to live, or a testing/tooling detail — it isn't a concept; leave it out. One line per entry: what it does, in implementation-independent terms, and a link to its source of truth. That link should point at where the concept actually lives (its code, or the README section that describes it) — not at a separate rationale document organized the same way the index is; that just duplicates the index's own structure (see Locality). Update it whenever a concept is added or removed. Organize it by conceptual similarity. Read it before writing new code or planning a feature.

## Comments

- **Comments Are Documentation.**All the same rules and guidelines that apply to documentation, also apply to code comments.
- **Code is Authoritative.** Never write a comment that a reasonably competent developer could infer from reading the code. Document what the code doesn't already say. Expect the reader to get the rest from the code itself — a descriptive name, a type, or an idempotent guard already states its own fact, so don't add a comment that just restates it in prose (e.g. a well-named field needs no comment repeating the name; a function documented at its own definition needs no repeat of that at each call site).
- **Comments Are DRY Too.** Never put exact values in a comment that duplicate what's already in code. If a value or symbol is computed, the comment should not repeat the outcome of the computation.
- **Explicitly Banned Comment Forms:**
     - Comments restating the code (`// increment the counter`, `// early return`)
     - Negations: "not doing X", "X is intentionally omitted", "no longer needs Y"
     - History: "removed X because of Y", "previously used Z", "changed from A to B"
     - Change narration: "added to fix the failing test", "updated per request", "as discussed"
     - Test references of any kind
     - Section banners, dividers, `// --- helpers ---`
     - Docblocks on self-describing functions, or param docs that repeat the signature

## Automated Tests

- **Self Documenting Tests.** When writing automated tests, instead of describing the test in a comment, if the test engine supports it, use a short, repeatable name for the test case, and include the test description as a string, visible near the top of the test case. When the test fails, emit that string as additional information for diagnosing the test.
- **Tests Are Observers.** Tests are consumers of the system. They do not get to alter its structure. Never do any of the following:
     - Export a binding just so a test can read it
     - Widen visibility (private to public, module-local to exported) for a test
     - Add a setter, hook, flag, injection point, or `reset()` that exists only for test setup
     - Add code that sets a property to a specific value because a test asserts on it
     - Transform or normalise a value at the read site so it matches what a test expects
- **Tests Use Public Interfaces.** When a test cannot reach what it needs, exactly one of these is true. Say which:
     - The test asserts on an implementation detail. Rewrite the test to assert on observable behaviour.
     - The module genuinely lacks a seam. Describe the seam you would add and wait for approval.
- **Explain Regressions.** When a pre-existing test fails, state whether the test or the code is wrong, and why, before changing either.

## Fixing Defects
 
- **Diagnose Before Editing.** Before changing any code to fix a defect, state:
     - *Symptom:* what is observably wrong
     - *Origin:* `file:line` where the wrong value or behaviour is first produced
     - *Why here:* why this is the origin rather than a downstream victim of it
- **Fix Root Causes.** If a change corrects a value *after* something else produced it wrongly, the change is in the wrong place. Update the producer. If the diagnosis is uncertain, say so and investigate. Do not apply a plausible fix to see if it works.
- **Large Change Guard**: A large diff for a small defect means the defect was misdiagnosed. Report that rather than proceeding. Stop and present a plan instead of editing when any of these hold:
     - The fix requires touching more than three files
     - The fix introduces a new abstraction, module, or indirection layer
     - The fix adds more than ~15 net lines to resolve a single defect
     - The correct fix would change a public interface or a shared contract
- **No Stacked Fixes.** If a fix does not work, do not add a second fix on top of it. Revert the failed attempt, then state what the original diagnosis got wrong before attempting anything else. Two failed attempts on the same symptom means stop and report, with the evidence gathered so far. Never leave a superseded attempt in place "in case it helps". Layered guards, redundant normalisation, and defensive re-checks accumulated across attempts are worse than the original defect.
- **Deletion is a Fix.** Removing code is a legitimate and preferred resolution. Prefer, in order:
     1. Delete the code that produces the problem
     2. Correct the code that produces the problem
     3. Adapt the code that consumes it

# Other Rules

## New Repo Creation

Apply these both when creating a new repo and on an ongoing basis to any repo you create or own (github user `markmckenna`).

- Put agent-specific instructions in `AGENTS.md`: workflow and conventions for how an agent should work in this repo. Keep out anything a human contributor would also want to read — architecture, design rationale, tech-stack choices, layout conventions — that belongs in `README.md`/`docs/` instead, with `AGENTS.md` linking to it rather than restating it.
- Put human-facing usage docs in `README.md` — every directory may have one, and it's that directory's human landing page.
- Read `README.md` too, as an agent — humans shouldn't have to read `AGENTS.md`, and `AGENTS.md` shouldn't need to repeat what `README.md` already says.
- Give every repo an idempotent root `init.sh` that gets it ready for development/testing.
- Use `make` as the repo root's primary automation tool (see Make, below).
- Follow the validation rules below (see Validation).

## Sandbox violations

When a Bash command fails with a sandbox violation, do not work around it.
Stop and report:

- the exact path or host the sandbox denied
- which program wanted it and what it was trying to do there
- whether it needs read or write access, and whether it's transient
  (a socket, a lock file) or persistent state
- at least two options: the narrowest `sandbox.filesystem.allowWrite`
  entry that would fix it, and a way to avoid needing the access at all
  (different flag, different tool, config change, or me running the
  command myself)

Then wait. Do not edit .claude/settings.local.json until I say which
option I want.

## Make

Give each subproject its own `Makefile` if the repo is subdivided.

Name `make` targets by what they do, using this vocabulary:
- `help` — list the main commands available under `make` (this is the default)
- `init` — set up the repo for development.
- `build` — run a normal build, incrementally where possible, if this project has one.
- `check` — run every automated validation in the repo; exit 0 on success, nonzero on failure — see Validation, below, for the script this target must agree with.
- `run` — run an interactive version of the software, if that's appropriate.
- `start` — start the software as a local service, attached to the terminal so Ctrl+C stops it, building first if needed, if that's appropriate.
- `watch` — same as `start`, but also watch for changes and restart/hot-reload, if that's appropriate (alias it to `start` if `start` already does this).
- `clean` — delete temporary files and caches that are quick to regenerate. Leave hand-made configuration alone. Make the next `build` a full build.
- `veryclean` — do what `clean` does, then delete virtually everything not under source control, back to a vanilla checkout. Clear repo-stored caches. Leave alone dependencies stored outside the repo, and anything other repos might use.

Add as many further targets as are useful to run standalone or that clarify the repo's usage — treat `make` as a command tree. Prefer a shell script over complex logic directly in a Makefile.

Document what each target actually does as a comment above it in the Makefile itself — that's its source of truth, found the moment someone opens the file. Don't also restate target behavior in `AGENTS.md`/`README.md`; point to the Makefile instead.

## Dev Cycle

- Break the task into logical steps before starting.
- Commit periodically while working.
- Run automated validations as you go. Treat a failing validation as a sign the task isn't done, except for a failure that already existed before your change.
- Write a new automated validation for anything that can reasonably be validated.
- Write an automated validation for any failure you hit, especially a regression — something that used to work and doesn't now.
- After each work cycle, report a summary: tools used, token counts by phase, validations run, and any issues hit.
- Look for ways to work more efficiently, and add them to `AGENTS.md` so future agents inherit them.

## Validation

Apply this to any validation, whether it checks code, your own behavior, documentation structure, or anything else.

- Use `make check` at the root to validate everything in the whole repository.
- This should delegate to other more specific make commands for validation, where needed.
- Nontrivial validators should wrap logic in a shell script under `tools/`.
- All validators exit 0 on success, nonzero on failure.
- On success, validators only emit a single token: `PASSED`. This is true of validator collections too (i.e. they should suppress the output of upstream validators)
- On failure, validators list each validation that failed, combined with diagnostic information that helps to localize the failure, where possible with instructions that an agent would understand.
     - This should be specific to the failure in question (i.e. each test/validator should contain within it enough output to instruct someone in where to go to find/fix the problem that that test validates).
- Failing output must also be stored in a temporary file, and the name of the temporary file given in the failure result text.

## Architecture

- Code should be highly organized conceptually. Use known tools and metrics to make sure it is well organized.
- Keep tools like LSP, knip, eslint, dependency-cruiser, and ast-grep in your back pocket for validating structural composition rules, code quality and so on.
- Use metrics like cyclomatic complexity, reachability, cross-module reference count, and related concepts to help assess how well or poorly things are conceptually aligned.
- However more broadly, what makes code well organized is that things that are conceptually similar are close together, and things that are highly likely to change together are kept together. There is no metric for this; use judgment and consideration when writing code.
- Every time you want to add code to a file, ask the question "what conceptual module should this code belong to?" Don't create cross-component dependencies just to keep similar code together, but consider refactoring out a common component in order to do so.

## Repository Structure

Apply these conventions whenever setting up a new repository.

- Make `make` reachable from the repo root, even when the repo is subdivided into separate projects.
- Make the root `README.md` a stepping-off point for the whole repo.
- Put tools that operate the repository in `tools/`.
- Put anything generated by building, testing, or using the repo under `build/`, and `.gitignore` it.
- Push configuration into `config/`.
- Store documentation under `docs/`, unless it's better placed alongside the component it describes.
- Give each subproject its own directory off the root, each following this same breakdown, if the repo is grouped into subprojects.

## Task Completion Checklist
 
Confirm each of these before considering the task done, and before committing any code. If any fails, fix it before showing me anything:
 
- [ ] Every added comment survives the deletion test
- [ ] No comment mentions tests, history, requests, or what the code does not do
- [ ] No binding was exported, widened, or added for a test's benefit
- [ ] No value is corrected downstream of where it is produced
- [ ] No remnants of an earlier failed attempt remain
