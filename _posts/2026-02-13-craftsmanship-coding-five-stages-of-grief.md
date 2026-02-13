---
layout: post
title: "Craftsmanship coding and the five stages of grief"
date: 2026-02-13 12:00:00 -0300
tags: ai automation system-design testing
---

If you've been reading recent Hacker News threads, you've probably noticed a recurring tone: a recurring mourning for "craftsmanship" in software, for the clay-in-hands feeling of shaping code line by line.

Here's some evidence:

- ["We mourn our craft"](https://news.ycombinator.com/item?id=46926245)
- ["I miss thinking hard"](https://news.ycombinator.com/item?id=46881264)
- ["I started programming when I was 7... the thing I loved has changed"](https://news.ycombinator.com/item?id=46960675)
- And, of course, existential dread about ["slop" eating the internet](https://news.ycombinator.com/item?id=46933067)

If we borrow the "five stages of grief" as a metaphor, it feels like part of our industry is hovering around **depression**. Not because people are lacking resilience, but because the change is structural, not cosmetic. And structural change hits identity.

The next stage is **acceptance**.

Not "AI will code everything," but "AI will code most of it", and in many teams, it already does. But what does that mean? Simply put, software engineers will delegate most tasks to AI.

Here's some truth about professional software:

> Most developer time isn't cathedral-building. It's digital plumbing.
>
> It's reading code, changing code, moving data between systems, integrating APIs, handling edge cases, and keeping production stable.

That's exactly where "agentic coding" is already meaningfully useful, because it's fast at the repetitive, low-cognition parts, and when you can verify outputs/diffs (with your own eyes) cheaply. So why not use it in this context?

But bear in mind: most tasks don't mean most value. So at a minimum treat agentic coding as a great tool to delegate lower-value tasks so that you can spend more time on higher-value work.

## A practical ladder (most to least delegable)

{:.basic-table}
| Work type                             | What agents are good at             | Your job stays                              |
| ------------------------------------- | ----------------------------------- | ------------------------------------------- |
| CRUD                                  | patterns, scaffolding, consistency  | schema/constraints, tests, review           |
| Data plumbing / transfer              | adapters, ETL-ish glue, client code | contracts, failure modes, monitoring        |
| Simple transformations / integrations | deterministic changes, refactors    | golden tests, invariants, change safety     |
| Algorithms (well-specified)           | standard approaches + edge handling | spec, complexity targets, property tests    |
| Architecture                          | exploring options, drafting designs | making implicit constraints explicit        |
| High-assurance software               | helping with review and test drafts | ownership, compliance, zero-tolerance gates |

There are many levels of delegation; it isn't (and shouldn't be) all-or-nothing. The less complex, less sensitive, and more reversible a task is, the more you can delegate the bulk of the work and let the agent drive. At the other end of the spectrum—complex or high-stakes work where failures are costly and reversals are painful: you keep your hands on the wheel.

## What I've experienced in real projects

When the codebase has clear boundaries and coherent architecture, agents can be genuinely productive. When it's spaghetti code, agents degrade quickly and produce mediocre output, because the system itself has weak signals.

Starting projects from scratch with agentic tools is also possible, but usually harder. You can make it work, but only if you provide much stronger specs. The broader and more ambiguous the task, the worse the output variance.

In other words, agents excel when scope is narrower, objectives are explicit, and review is cheap. The best use cases are tasks you'd feel comfortable coding yourself: you can write clear instructions, verify results, and do small adjustments before shipping.

That's where the efficiency gains are real.

## How to stay ahead in an agentic world

It isn't about typing faster. It's about moving craftsmanship upstream.

When agents write more of the code, the "handmade" part doesn't disappear, it relocates. Craft becomes the ability to shape intent into constraints, turn ambiguity into decisions, and build systems where correctness is the default, not a happy accident.

Acceptance is not surrender. It's admitting that most work is plumbing, and choosing to spend your human attention where it compounds: on higher-value, higher-stakes tasks.

So I say embrace the new paradigm agentic tools enable, where specification and intent are ever more important, low-complexity tasks delegated in bulk, and we can leverage our time to focus on higher-level challenges.