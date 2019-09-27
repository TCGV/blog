---
layout: post
title: "Data structures complexity reference"
date: 2019-08-05 07:45:00 -0300
comments: true
tags: data-structures complexity-theory
---

Quick complexity reference for most common data structures, considering efficient implementations usually available in frameworks class libraries.

Array
============

Time Complexity:

{:.basic-table}
|              | Average | Worst |
| ------------ | ------- | ------|
| **Indexing** | O(1)    | O(1)  |
| **Search**   | O(n)    | O(n)  |
| **Insert**   | O(n)    | O(n)  |
| **Delete**   | O(n)    | O(n)  |

Space Complexity: `O(n)`


Linked List
============

Time Complexity:

{:.basic-table}
|              | Average | Worst |
| ------------ | ------- | ------|
| **Indexing** | O(n)    | O(n)  |
| **Search**   | O(n)    | O(n)  |
| **Insert**   | O(1)    | O(1)  |
| **Delete**   | O(1)    | O(1)  |

Space Complexity: `O(n)`

*For both single-linked and doubly-linked lists*


Stack
============

Time Complexity:

{:.basic-table}
|          | Average | Worst |
| -------- | ------- | ------|
| **Push** | O(1)    | O(1)  |
| **Pop**  | O(1)    | O(1)  |

Space Complexity: `O(n)`


Queue
============

Time Complexity:

{:.basic-table}
|              | Average | Worst |
| ------------ | ------- | ------|
| **Enqueue**  | O(1)    | O(1)  |
| **Dequeue**  | O(1)    | O(1)  |

Space Complexity: `O(n)`


Hash Table
============

Time Complexity:

{:.basic-table}
|              | Average | Worst |
| ------------ | ------- | ------|
| **Search**   | O(1)    | O(n)  |
| **Insert**   | O(1)    | O(n)  |
| **Delete**   | O(1)    | O(n)  |

Space Complexity: `O(n)`


Heap
============

Time Complexity:

{:.basic-table}
|              | Average   | Worst     |
| ------------ | --------- | --------- |
| **Heapify**  | O(n)      | O(n)      |
| **Find Max** | O(1)      | O(1)      |
| **Insert**   | O(log(n)) | O(log(n)) |
| **Delete**   | O(log(n)) | O(log(n)) |

Space Complexity: `O(n)`


Binary Search Tree
============

Time Complexity:

{:.basic-table}
|              | Average   | Worst     |
| ------------ | --------- | --------- |
| **Indexing** | O(log(n)) | O(n)      |
| **Search**   | O(log(n)) | O(n)      |
| **Insert**   | O(log(n)) | O(n)      |
| **Delete**   | O(log(n)) | O(n)      |

Space Complexity: `O(n)`


Self-balancing Binary Search Tree
============

Time Complexity:

{:.basic-table}
|              | Average   | Worst     |
| ------------ | --------- | --------- |
| **Indexing** | O(log(n)) | O(log(n)) |
| **Search**   | O(log(n)) | O(log(n)) |
| **Insert**   | O(log(n)) | O(log(n)) |
| **Delete**   | O(log(n)) | O(log(n)) |

Space Complexity: `O(n)`

*Ex: AVL Tree, Red-Black Tree*


Trie
============

Time Complexity:

{:.basic-table}
|              | Average   | Worst     |
| ------------ | --------- | --------- |
| **Search**   | O(m)      | O(m)      |
| **Insert**   | O(m)      | O(m)      |
| **Delete**   | O(m)      | O(m)      |

Space Complexity: `O(m * l)`

Where:
* `m` is the length of the search string
* `l` is the length of the character alphabet