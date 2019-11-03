---
layout: post
title: "Why is it hard to name classes?"
date: 2019-10-02 09:00:00 -0300
tags: oop
---

When following the Single Responsibility Principle (SRP) we are frequently required to encapsulate code into new classes, segregating responsibility from one "bigger" class into smaller, granular classes. Clean code guidelines states that classes names should be meaningful and describe the intent of the class, i.e., by reading a class name one should have a close idea of what it does.

As much as we're constantly discouraged from using generic suffixes in classes names such as `Manager`, `Handler`, `Verifier`, etc, we often can't figure out a great name for a class and end up making use of them. So the question hangs, why is it hard to name classes?

> Here's one unusual answer: Vocabulary.

There are "only" so many nouns in the English language (the de facto working language in computing), and actually when modeling real objects in code classes names come quite naturally. We've all seen the "animals" example for explaining inheritance:

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

Naming animal classes is easy because it's within our basic vocabulary. However, naming classes whose purposes are either too specific or not relatable to real things is hard because we either have to use a more sophisticated vocabulary, or invent names ourselves, since there may not be a noun in the English language for it!

For instance, try naming the following classes:

**1)** A class responsible for holding a user's financial information, such as credit cards, social security number, bank account access keys, etc.

**2)** A class responsible for evaluating the risk associated with an offshore IP Address trying to connect to a website with rigorous security requirements.

The first one is straight forward: `Wallet`. The second one not so much, leading us to those not well regarded naming approaches: `IPRiskManager`, `IPVerifier`, `IPChecker`, and so forth.