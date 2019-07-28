---
layout: post
title: "Using queues to offload Web API"
date: 2019-07-28 11:45:00 -0300
comments: true
tags: system-design queuing
---

With the ubiquitous of smartphones and mobile devices a great number of people are getting more and more accustomed to accessing all kinds of digital services remotely, anywhere they feel convenient to do so. The adoption of web APIs to back these digital services is now even more customary, and the performance of web APIs will have a direct impact on user experience (UX).

This article presents a technique for optimizing web APIs by offloading part of its operations to asynchronous queues, resulting in faster response times and improved UX. First we analyze the anatomy of a web API request, then we introduce the structure of a queuing system, and finally we combine both for achieving more efficient execution flows.

Anatomy of a Web API Request
============

A great deal of backend services are composed of a web API module on top of a database. In this model code is only executed on demand, i.e., whenever the API gets called. There are no background processes executing behind the scenes. It is simple to develop and operations are predictable, easy to follow.

This model can be pushed really far, as long as the API constraints itself to light weight operations with simple interactions. However, if there's a need to implement more complex and demanding operations sticking to this model will result in longer processing times and degraded performance. The diagrams below helps understand why:

<p align="center">
  <img style="max-height: 300px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p2/light-web-request.JPG" alt="light-web-request"/>
  <br><label style="font-size: 12px;">figure 1</label>
</p>

In light weight web API requests calls arrive at the endpoint, are routed to the application, business logic is executed, perhaps fetching or persisting some data, and finally a response is produced and returned to the client. Operations are mostly short in duration and everything runs within the application boundaries.

<p align="center">
  <img style="max-height: 385px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p2/heavy-web-request.JPG" alt="heavy-web-request"/>
  <br><label style="font-size: 12px;">figure 2</label>
</p>

In more complex web API requests a lot more is going on. Secondary web requests may be triggered in response to the primary request, multiple database queries may be required for processing data and more sophisticated algorithms may be executed in the request main thread. As the diagram shows, these operations will last longer and are not limited to the application boundaries.

Naturally, as operations grow in complexity comes the need for an improved application architecture for orchestrating execution flows and preserving general web API consistency.

The Queuing System
============

A typical queuing system is composed of a message broker program which provides a publisher/subscriber interface for interacting with named message queues. A message queue is a store of published messages, which are consumed in sequential or prioritized order by one or more subscribers. The message broker provides numerous configuration options for handling messages, including:
* <b>Durability</b>: messages may be stored in memory, written to disk, or committed to a database depending on reliability requirements
* <b>Routing policies</b>: in scenarios with multiple message brokers these policies define which servers to publish/subscribe messages
* <b>Message filtering</b>: specific criteria may be applied to determine which messages are available to individual subscribers
* <b>Purging policies</b>: messages may have an expiration, after which they are automatically purged
* <b>Acknowledgement notification</b>: the broker may wait an acknowledgement from the subscriber before committing a message queue removal

<p align="center">
  <img style="max-height: 250px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p2/message-broker.JPG" alt="message-broker"/>
  <br><label style="font-size: 12px;">figure 3</label>
</p>

Message queues are a great solution for orchestrating asynchronous communications. In the image above we have three publishers connected to the broker, publishing messages to three different queues. On the other end four subscribers are also connected to the broker consuming messages from these queues. Routing is flexible and performed internally by the broker.

This example is only illustrative, and depending on application requirements we can have several types of relationships between publisher-queue-subscriber. Typically for small scale systems we will see multiple publishers submitting messages to a queue which has a single subscriber consuming it. For larger distributed systems it's common to have multiple subscribers consuming from the same queue, each one of them potentially running in a different server for higher performance and availability.


Improving Execution Flow
============

Let's suppose the sequence diagram from **figure 2** represents a social media content "like" operation as follows:
1. Mobile App sends a *Like* request providing *authenticationToken* and *contentId* parameters
2. Web API receives the request, parses the parameters and validates the *authenticationToken* against the Database
3. Upon successful validation it proceeds to persist a *LikeAction* entry into the Database, associating it with *contentId*
4. Then it fetches information about the content author, and prepares a push notification request
5. The push notification request is sent to an external cloud notification service for processing
6. Upon receiving a confirmation from the external service the Web API returns a success response to the Mobile App

Notice that steps 3-6 are great candidates for being processed asynchronously, based on a few observations:
* The mobile app response is not dependent on the result of these operations
* A background worker executing these steps can handle execution errors independently

With that in mind we can introduce a Broker and a Worker components to the aplication, breaking the web API request execution flow into a shorter operation and a subsequent asynchronous operation. The original request will be reduced to:
1. Mobile App sends a *Like* request providing *authenticationToken* and *contentId* parameters
2. Web API receives the request, parses the parameters and validates the *authenticationToken* against the Database
3. Upon successful validation it proceeds to publish a *LikeAction* message to the Broker
4. Upon receiving a confirmation from the Broker the Web API returns a success response to the Mobile App

The third step above enqueues a message into the queue, which will eventually trigger the following asynchronous operation:
1. The Broker delivers a *LikeAction* message to the Worker, which is subscribed to this queue
1. The Worker persists a *LikeAction* entry into the Database, associating it with *contentId*
2. Then it fetches information about the content author, and prepares a push notification request
3. The push notification request is sent to an external cloud notification service for processing
4. Upon receiving a confirmation from the external service the Worker completes processing the queue message, and stops

The resulting operation is presented below:

<p align="center">
  <img style="max-height: 385px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p2/queue-sequence.JPG" alt="queue-sequence"/>
  <br><label style="font-size: 12px;">figure 4</label>
</p>

Notice that the main web API request duration is now much shorter. One can argue that this technique should be incorporated to the system design since its conception, and applied systematically whenever the conditions above are met, resulting in a more efficient web API and more granular, independent code.

---

**Bonus tip**: Besides offloading web API requests, the usage of a queuing system also allows the distribution of CPU usage over time, reducing processing spikes and improving system stability. It's easy to see why: message queues can handle operations sequentially that would otherwise be processed immediately, potentially at the same time.