---
layout: post
title: "The burden of complexity"
date: 2023-04-10 13:30:00 -0300
tags: collaboration project-management
---

Complexity is present in any project. Some have more, some have less, but it's always there. The manner in which a team handles complexity can pave the way for a project’s success or lead towards its technical demise.

In the context of software, complexity arises from a variety of factors, such as complicated requirements, technical dependencies, large codebases, integration challenges, architectural decisions, team dynamics, among others.

When talking to non-technical folks, especially those not acquainted with the concepts of software complexity and technical debt, it can be helpful to present the topic from a more managerial perspective.

So I propose the following qualitative diagram that regards complexity as an inherent property of a software project, and simultaneously, a responsibility that a software development team must constantly watch and manage for being able to deliver value in the long run:

<p align="center">
  <img style="max-width: 100%; max-height: 400px; margin: 10px 0 10px -40px" src="{{ site.baseurl }}/images/p31/complexity-burden-diagram.png" alt="surface"/>
  <br><label style="font-size: 12px;">Figure 1. The Complexity Burden Diagram</label>
</p>

First, some definitions:

* The <b style="color:blue">Complexity Burden</b> curve is the theoretical amount of effort needed for servicing the level of complexity of a project. If the team spends less than this amount the project accumulates additional complexity. Conversely, if the team invests more than this amount, they can reduce complexity and bring the project to a more sustainable state.

* The <b style="color:gray">Team's Capacity</b> line is the maximum amount of effort the team is able to provide, which varies over time and can be influenced by factors such as changes in the product development process, team size, and efforts to eliminate toil [1]. Additionally, reductions in the complexity burden of a project can unlock productivity, influencing the team's capacity as well.

* The <b style="color:gray">Complexity Threshold</b> represents the point where the team's capacity becomes equal to the complexity burden. In this theoretical situation, the team can only allocate capacity towards servicing the complexity. Value delivery is compromised.

Now that we have these definitions in place, let's review the two colored zones depicted in the diagram.

<h2>The Improvment Zone</h2>

This is the ideal place to be. <u>The team has more than enough capacity for servicing complexity</u>, and can safely invest the remaining (i.e. free) capacity in the advancement of the project. The higher the proportion of free capacity, the more productive and efficient the team will be in delivering value. They can choose to innovate, develop new features, optimize performance and improve the UX. It's worth noting that doing so may result in added complexity. This is acceptable as long as there is enough capacity to deal with the added complexity in the next cycles of development and the team remains continuously committed to addressing technical debt.

<h2>The Degradation Zone</h2>

A project enters the degradation zone when <u>the team's capacity is inferior than the required maintenance effort</u>, leading to a difficult situation. The team's inability for servicing the complexity burden may result in added pressure on an already strangled project. The team will constantly be putting out fires, new features will take longer to ship, developers may suggest rewriting the application, and customers may not be satisfied. The only viable ways out of this situation are to significantly reduce complexity or to increase capacity. Other efforts will be mostly fruitless.

Closing Thoughts
============

The concept of complexity burden can be a valuable tool for enriching discussions around promoting long-term value delivery and preventing a project from becoming bogged down by complexity, leaving little room for new feature development. It's important to make decisions with a clear understanding of the complexity burden and how it may be affected.

It's worth pointing out that if the free capacity of a team is narrow, meaning if the proportion of effort allocated towards managing the complexity burden is already too high, the team will find itself in a situation where continuing to innovate may be too risky. The wise decision then will be to prioritize paying off technical debt and investing in tasks that mitigate risk.

Finally, a project is a dynamic endeavor, and a team may find itself in the "degradation" zone in one sprint and in the "improvement" zone in the next. What matters most is to be aware of the current context and plan next steps while viewing the bigger picture.

---

<b>Reference</b>

[1] [Google - Site Reliability Engineering. Chapter 5 - Eliminating Toil.](https://sre.google/sre-book/eliminating-toil/)
