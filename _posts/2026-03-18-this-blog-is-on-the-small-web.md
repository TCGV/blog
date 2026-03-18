---
layout: post
title: "This blog is on the Small Web"
date: 2026-03-18 13:00:00 -0300
tags: ai blogging
---

This blog is on the Small Web
============

I was browsing Hacker News yesterday and saw a post titled [Kagi Small Web](https://news.ycombinator.com/item?id=47410542) ranking high on the front page. Curiosity got the better of me, so I clicked through. I ended up spending some time there just jumping through random posts comprised of actually interesting stuff written by real people, not the usual SEO-optimized or AI "slop" we see everywhere now.

Then I did a bit of digging. It turns out, this blog is on that list too 🙂

What is this list?
============
I went over to their [GitHub repository](https://github.com/kagisearch/smallweb) to see what was going on. As of today, the `smallweb.txt` file is comprised of **34,492** blogs and personal websites. It's basically a very large, curated index of (a more?) "human" internet.

If you're wondering how a site gets included, they have a [specific set of rules](https://github.com/kagisearch/smallweb?tab=readme-ov-file#%EF%B8%8F-guidelines-for-site-inclusion-to-the-list-%EF%B8%8F):
* **Non-Commercial:** No intrusive ads, paywalls, or heavy affiliate marketing.
* **Human-Centric:** Absolutely no AI-generated or LLM "spam" content.
* **Technical:** You must have a valid RSS or Atom feed.
* **Recent-ish:** The blog needs at least one post in the last 12 months to stay in the index.
* **Personal:** It favors personal diaries, niche technical deep-dives, and independent essays over corporate blogs or newsletters (Substack seems like a no-go).

Turns out, these criteria favor both better content and a better experience—exactly what I value.

Seven years of "Zero Maintenance"
============
I actually never submitted my blog to be included. It likely got picked up because I've been running this blog for seven years now. I use **Jekyll** - don't know if it's still a thing, but it works. 

The best part? Jekyll generates an RSS feed out of the box, which turned out to be one of the requirements for getting indexed by Kagi. I host everything on [GitHub Pages](https://github.com/TCGV/blog), which I highly recommend. It's free, requires zero maintenance time, and it's surprisingly robust. It can handle a "Hacker News hug of death" without breaking a sweat whenever one of my posts accidentally hits the front page.

If you've been thinking about starting your own blog and you have some technical skills, you don't need a complex setup / CMS. You could literally just [clone my repo](https://github.com/TCGV/blog), restyle the layout, and set up your own domain on GitHub Pages for free.

Is the small web actually useful?
============
The [original HN thread](https://news.ycombinator.com/item?id=47410542) had some mixed feelings. A few people were underwhelmed by the current implementation, calling it "more like a curated blog ring than a discovery engine for the broader indie web." Others were more optimistic, acknowledging that it's a "good idea with a decent foundation."

Personally, I just appreciate the small bit of recognition. In a world where every search result feels like it was written by a bot to sell me a mattress, it's nice to be officially part of the "Small Web", even more since even more ince I didn't subscribe myself to the list.

---

Cheers 🍻