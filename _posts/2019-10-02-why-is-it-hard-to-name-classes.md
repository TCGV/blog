---
layout: post
title: "Why is it hard to name classes?"
date: 2019-10-02 09:00:00 -0300
tags: oop
---

When following the Single Responsibility Principle (SRP) we are frequently required to encapsulate code into new classes, segregating responsibility from one "bigger" class into smaller, granular classes. Clean code guidelines state that classes names should be meaningful and describe the intent of the class, i.e., by reading a class name one should have a close idea of what it does.

As much as we're constantly encouraged for writing meaningful code and being thoughtful when naming things, reducing the use of loosely generic suffixes in classes names such as `Helper` and `Manager`, we often can't figure out a great name for a class and end up making use of them. So the question hangs, why is it hard to name classes?

> Here's one unusual answer: Vocabulary.

There are "only" so many nouns in the English language (the de facto working language in computing), and actually when modeling real objects in code classes names come quite naturally. We've all seen the elucidatory "animals" example for explaining inheritance:

```csharp
public abstract class Animal
{
    public abstract Eat();

    public abstract Sleep();

    public abstract WakeUp();
}
```

```csharp
public abstract class Fish : Animal
{
    public abstract Swim();
}
```

```csharp
public abstract class Bird : Animal
{
    public abstract Fly();
}
```

Naming animal classes is easy because it's within our basic vocabulary, but not much useful. How many times have you designed an application in which you had to model different kinds of animals?

Naming classes whose purposes are either too specific or not relatable to real things is harder because we either have to use a more sophisticated vocabulary, or invent names ourselves, since there may not be a noun (or a composition of nouns) in the English language for properly describing it!

For instance, try naming the following classes:

**1)** A class responsible for maintaining a set of financial transactions and balances, and provide the ability to create new financial transactions.

**2)** A class responsible for evaluating the risk associated with an offshore IP Address trying to connect to a website with rigorous security requirements.

The first one is straight forward: `Wallet`. The second one less so, leading us to a more wide set of naming options to choose from: `IPRiskManager`, `IPVerifier`, `IPChecker`, and so forth.

So, are all class name suffixes evil?
============

Not at all. Well defined behavioral / contextual suffixes are a great tool for producing more intuitive code, reducing the cognitive effort for reading and navigating though the codebase, and that's why it's widely used in architectural patterns and frameworks. Here are just a few examples that come to mind: Builder, Factory, Repository, View, Controller, and so forth. The list is endless.

Conclusion
============

Naming classes is part of our daily tasks as software developers. When components relate to already existing tangible things or clear concepts within our vocabulary class names may come up more naturally, and the opposite might occur when we are dealing with highly specific constructs.

Expanding our vocabulary to use domain specific nouns can be useful for enriching both our system design as well as our knowledge in the field we are working in. Even so, sometimes it's not possible to find simple, relatable terms to adopt for naming classes. In such cases relying on prefix/suffix naming conventions is a good option, or falling back to a neologism strategy for creating descriptive composed nouns.

---

<b>Notes</b>

* Revised on Jun 17, 2020. For reference you can find the original article [here](https://github.com/TCGV/blog/blob/448d845f3baa8d678bb02c990a6c6cbbfb3ccf40/_posts/2019-10-02-why-is-it-hard-to-name-classes.md).