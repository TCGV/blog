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
|             | Indexing | Search | Insert | Delete |
| ----------- | -------- | ------ | ------ | ------ |
| **Average** | O(1)     | O(n)   | O(n)   | O(n)   |
| **Worst**   | O(1)     | O(n)   | O(n)   | O(n)   |

Space Complexity: `O(n)`


Linked List
============

Time Complexity:

{:.basic-table}
|             | Indexing | Search | Insert | Delete |
| ----------- | -------- | ------ | ------ | ------ |
| **Average** | O(n)     | O(n)   | O(1)   | O(1)   |
| **Worst**   | O(n)     | O(n)   | O(1)   | O(1)   |

Space Complexity: `O(n)`

*For both single-linked and doubly-linked lists*


Stack
============

Time Complexity:

{:.basic-table}
|             | Push    | Pop     |
| ----------- | ------- | ------- |
| **Average** | O(1)    | O(1)    |
| **Worst**   | O(1)    | O(1)    |

Space Complexity: `O(n)`


Queue
============

Time Complexity:

{:.basic-table}
|             | Enqueue | Dequeue |
| ----------- | ------- | ------- |
| **Average** | O(1)    | O(1)    |
| **Worst**   | O(1)    | O(1)    |

Space Complexity: `O(n)`


Hash Table
============

Time Complexity:

{:.basic-table}
|             | Search | Insert | Delete |
| ----------- | ------ | ------ | ------ |
| **Average** | O(1)   | O(1)   | O(1)   |
| **Worst**   | O(n)   | O(n)   | O(n)   |

Space Complexity: `O(n)`


Heap
============

Time Complexity:

{:.basic-table}
|             | Heapify  | Find Max | Insert    | Delete    |
| ----------- | -------- | -------- | --------- | --------- |
| **Average** | O(n)     | O(1)     | O(log(n)) | O(log(n)) |
| **Worst**   | O(n)     | O(1)     | O(log(n)) | O(log(n)) |

Space Complexity: `O(n)`


Binary Search Tree
============

Time Complexity:

{:.basic-table}
|             | Indexing  | Search    | Insert    | Delete    |
| ----------- | --------- | --------- | --------- | --------- |
| **Average** | O(log(n)) | O(log(n)) | O(log(n)) | O(log(n)) |
| **Worst**   | O(n)      | O(n)      | O(n)      | O(n)      |

Space Complexity: `O(n)`


Self-balancing Binary Search Tree
============

Time Complexity:

{:.basic-table}
|             | Indexing  | Search    | Insert    | Delete    |
| ----------- | --------- | --------- | --------- | --------- |
| **Average** | O(log(n)) | O(log(n)) | O(log(n)) | O(log(n)) |
| **Worst**   | O(log(n)) | O(log(n)) | O(log(n)) | O(log(n)) |

Space Complexity: `O(n)`

*Ex: AVL Tree, Red-Black Tree*


Trie
============

Time Complexity:

{:.basic-table}
|             | Search    | Insert  | Delete |
| ----------- | --------- | ------- | ------ |
| **Average** | O(m)      | O(m)    | O(m)   |
| **Worst**   | O(m)      | O(m)    | O(m)   |

Space Complexity: `O(m * l)`

Where:
* `m` is the length of the search string
* `l` is the length of the character alphabet