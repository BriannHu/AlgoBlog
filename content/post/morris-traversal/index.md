---
title: Morris Traversal
description: Tree traversal algorithm without stack or recursion.
slug: morris-traversal
date: 2023-11-04 00:00:00+0000
tags: 
    - optimization
categories: 
    - algorithm
weight: 1 
---

## Overview

Morris Traversal is a tree traversal algorithm that does not use a stack or recursion. In the algorithm, links between different nodes are temporarily created, and are reverted upon traversal to restore the original tree.

## Problem
{{< quote >}}
Given a node `root` of a tree, perform an inorder traversal of the tree without using a stack or recursion.
{{< /quote >}}

## Algorithm

1. Initialize `curr` as `root`.
2. While `curr` is not `null`:
    - If `curr.left` is `null`:
        - Print `curr`'s data.
        - Continue right, set `curr` as `curr.right`.
    - Else: 
        - In the left subtree, make `curr` the right child of the rightmost node.
        - Continue left, set `curr` as `curr.left`.

## Implementation

```python
def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
    res = []
    curr = root
    while curr:
        if not curr.left:
            res.append(curr.val)
            curr = curr.right
        else:
            prev = curr.left
            while prev.right and prev.right != curr:
                prev = prev.right

            if not prev.right:
                prev.right = curr
                curr = curr.left
            else:
                prev.right = None # recovers the tree (optional)
                res.append(curr.val)
                curr = curr.right
    return res
```

## Analysis

### Time Complexity

$O(n)$: It might appear at first that the time complexity is $O(nlogn)$, given that finding the predecessor nodes for each node seems to take $O(logn)$, proportional to the height of the tree. However, finding all the predecessor nodes can be found in $O(n)$ time. Thus, the overall time complexity will be $O(n)$, with one pass to find all the predecessor nodes, and another pass to process all the nodes.

###  Space Complexity

$O(1)$: No extra space is used besides the node pointers which use constant space.

## Explanation

The following section explains some of the motivation behind the Morris Traversal algorithm, and is inspired by its [Wikipedia page](https://en.wikipedia.org/wiki/Threaded_binary_tree).

### Motivation

In *The Art of Computer Programming*, Donald Knuth speculated about the existence of a non-recursive algorithm for in-order traversal, which uses no stack and leaves the tree unmodified. Such an algorithm would prove useful for a hypothetical scenario involving traversing an infinite binary tree, which would be unable to be traversed using the typical recursive or stack-based algorithm.

A solution to this is tree threading, which was presented by Joseph M. Morris in 1979.

### Threaded Binary Tree

A threaded binary tree is a variation of the classic binary tree which facilitates traversal by incorporating threading links which point from certain nodes to others.

{{< quote >}}
A binary tree is threaded by making all right child pointers that would normally be null point to the in-order successor of the node (if it exists), and all left child pointers that would normally be null point to the in-order predecessor of the node.
{{< /quote >}}

Certain use cases arise from the need of different traversal orders; for example, a tree may have nodes representing people and is sorted by names, but have extra threads which allow for quick traversal in order of birth date, or other characteristics.


## Variations

- [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/)
- [Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal/)
- [Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/)
