---
layout: post
title: "Easy-wins for generative AI"
date: 2024-06-24 16:30:00 -0300
tags: ai system-design project-management
---

I will start this post with a direct question:

> What are the most useful generative AI-powered product features you regularly use?

Think about it for a while. The answer usually includes [1]:
1. Chat apps (e.g., ChatGPT, Google Gemini)
1. Media generation tools (e.g., audio, image, video)
1. Code generation extensions (e.g., GitHub Copilot, Code Whisperer)

These are indeed very useful! But weren't we promised that generative AI would completely change every aspect of our lives? So why can't most of us, specially non technical people, think of more examples to answer this question? The logical answer is that they aren't that prevalent, yet.

To add more context, it's not that no one is trying. We've all seen prominent companies investing significant resources to ride the generative AI bandwagon. However, many of them decided to chase home runs instead of easy-wins, and for that reason a lot of them failed [2].

So in this post, I'll argue that to successfully adopt generative AI in your product, you should focus on easy wins rather than home runs.


But what is an Easy-win?
======

An easy win, also known as a "low-hanging fruit," can be defined as any product feature that delivers significant value to the end user while having relatively low implementation complexity:

<p align="center">
  <img style="max-height: 240px; max-width: 100%; margin: 10px 0" src="{{ site.baseurl }}/images/p33/prioritization-matrix.PNG" alt="Prioritization matrix"/>
  <br><label style="font-size: 12px;">Figure 1. Prioritization matrix</label>
</p>

This concept originates from the prioritization matrix, a tool that helps teams manage tasks more efficiently, reduce viability risks, and optimize delivered value.

It may seem obvious to target easy wins, but more often that not we get carried away chasing shiny objects and commit to poorly assessed challenges.


How to discover gen AI easy-wins?
======

Considering that you may already have a working product that customers use (and love!), you should look for opportunities to improve your product's <b>existing</b> user flows to make them easier, faster, and more enjoyable.

If we go back to the start of this post we can see that the gen AI apps that we use more often are those that save us time, make us more productive. Focus on that, make your customers more productive. That's valuable.

One way I like to think of generative AI, contrary to the belief that it's a superintelligent being, is to consider it as <b>a very competent intern</b> — one that can receive generic instructions and carry out low cognitive complexity tasks with reasonable precision. So, in the context of easy wins, avoid assigning your competent intern tasks that are too broad in scope, overly complex, or demand extreme precision. Those aren't easy wins.

Additionally, anticipate and prepare for imprecise results from generative AI. If you start with a zero-tolerance policy for errors, you're likely to fail. Instead, design your solutions to support inexpensive review and regeneration cycles. This allows end users to easily assess the quality of the output and either accept it or quickly regenerate it if necessary.

Wrapping It Up:
1. Target existing user flows
1. Search for opportunities to make your users more productive
1. Adopt gen AI for low-cognitive, narrowly scoped tasks
1. Design for inexpensive review and regeneration cycles


A concrete example
======

I believe it's important to provide a real world example to illustrate how these principles can be applied in practice. At [MindMiners](https://mindminers.com/en), we offer innovative web and mobile market research solutions. Our customers create surveys on our platform and collect responses from our proprietary respondents panel via a mobile app.

One of the most time-consuming user flows on our platform is the questionnaire creation process, so we decided to focus on improving it. A common low cognitive complexity task for survey creators is listing options for multiple-choice questions based on the question text. To streamline this, we added a button for generating options.

Here's how it looks - And of course, we took the opportunity to add some marketing flair to the icon and label there 😉:

<p align="center">
  <img style="max-height: 320px; max-width: 100%; margin: 10px 0" src="{{ site.baseurl }}/images/p33/question-without-options.png" alt="Question without options"/>
  <br><label style="font-size: 12px;">Figure 2. Question without options</label>
</p>

Upon clicking this button, the platform constructs a simple prompt using the question text and requests a suggestion of options from the generative AI REST API. Once a result is generated, it is inserted into the frontend:

<p align="center">
  <img style="max-height: 484px; max-width: 100%; margin: 10px 0" src="{{ site.baseurl }}/images/p33/question-with-options.png" alt="Question with AI generated options"/>
  <br><label style="font-size: 12px;">Figure 3. Question with AI generated options</label>
</p>

If the end user is not satisfied with the results, they can easily and quickly regenerate the question options and even provide additional instructions, such as specifying the number of options.


Closing thoughts
======

In this post, I outline a strategy for identifying opportunities to leverage your existing product with generative AI. Instead of pursuing overly ambitious and sophisticated features, I advocate for starting with simpler yet highly valuable improvements. I present a concrete example of a technically straightforward feature that we have developed and that was very well received by our users, demonstrating the effectiveness of this approach.

---

<b>Reference</b>

[1] [Ask HN: What are some of the best user experiences with AI?](https://news.ycombinator.com/item?id=39789250)

[2] [Every app that adds AI looks like this](https://botharetrue.substack.com/p/every-app-that-adds-ai-looks-like)


