---
layout: post
title: "Code fluency"
date: 2021-01-27 22:00:00 -0300
tags: recruiting
---

More than a decade ago the [Using FizzBuzz to Find Developers who Grok Coding](https://imranontech.com/2007/01/24/using-fizzbuzz-to-find-developers-who-grok-coding/) blog post, by Imran Ghory, brought attention to the fact that most computer science graduates can't code simple problems out of the box. If you haven't heard of it I recommend reading it for more context.

Over the past few years as I became more involved in hiring developers for my team I was able to experience exactly what Imran describes in his blog post, having the opportunity to draw my own (additional) conclusions about it.

First, let me confirm what you already know and probably experienced yourself conducting interviews, it's true, the vast majority of recent graduates struggles to complete our "screening test" which is comprised of four really basic questions (two FizzBuzz style questions, and two conceptual open-ended questions) that experienced developers take about ten minutes to solve.

From my point of view this phenomenon is mainly a consequence of a lower code fluency level among young developers, i.e. the ability to read and write code with speed, accuracy, and proper expression, which as with any language (or idiom) comes with constant practice and not necessarily indicates that a person doesn't have what it takes to be a software developer or isn't fit for the software industry.

At this point we can raise some questions: are colleges in general providing enough practical programming classes? what exactly makes some candidates more fluent in code than others?

One trivial observation I made was that there's a strong correlation between recent graduates who perform well and those that actively code in their free time. It could be a hobby project, coding katas, or learning new languages and frameworks. Of course, by practicing more they become better prepared to solve problems at interviews, and more fluent in code, but more than that it's also an indication that they enjoy coding and are willing invest their free time (which recent graduates early in their lives more often than not have plenty) to improve their skills.

Another, more problematic, thing I noticed is that besides not being able to code problems most young developers aren't able to read code properly as well. Take the following snippet, which I regularly bring up at entry level interviews:

```csharp
Person a = new Person();
a.name = "Bob";

Person b = a;
b.name = "Jane";

print(a.name); // (1)
print(b.name); // (2)

a = null;

print(b.name); // (3)
print(a.name); // (4)
```

After presenting it and defining a base programming language (since some languages may handle variables different than others according to their type) I ask what's the expected outcome for (1), (2), (3) and (4). Sure, it's a tricky question that messes with variables and references, but not hard at all, and it shouldn't take more than thirty seconds for the average developer to answer it. Nevertheless I came to accept that most junior developers will fail this test at least partially.

I consider failing this and a few others code reading challenges more problematic, and not only a matter of lack of code fluency, because it reveals a cognitive bias in the developer mental model of how their code will behave that will possibly introduce furtive bugs in the codebase not detectable by a compact test suite. Providing feedback in failed interviews is a subject of its own, be that as it may these misconceptions should (somehow) be brought to light and dealt with as soon as possible for the benefit of the developer and the company he or she starts working for.

In sum achieving code fluency seems to be the first step in the ladder for becoming an experienced software developer. A large portion of young developers haven't taken that step yet, and are actually one step behind due to misconceptions about how code behaves. In turn those who have are more likely to secure several job offers to choose from upon starting their careers. Once this competency level is reached and a developer becomes fluent in coding he or she can aim for higher grounds such as becoming proficient in data structures, algorithms, design patterns, systems architecture and so forth.
