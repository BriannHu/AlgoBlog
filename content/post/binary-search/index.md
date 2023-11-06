---
title: Binary Search
description: Basic search algorithm for sorted array.
slug: binary-search
date: 2023-10-22 00:00:00+0000
tags: 
    - searching
categories: 
    - algorithm
weight: 1 
---
## Overview
 Binary search is a search algorithm that returns the index of a target value within a sorted array. Instead of iterating through each element of the array, it utilizes the sorted nature of the array to search more efficiently and improve the time complexity from $O(n)$ to $O(logn)$.

## Problem
{{< quote >}}
Given a sorted array `nums` and a target value `T`, return the index of `T` or -1 if it doesn't exist.
{{< /quote >}}

## Algorithm

1. Initialize a left boundary $L=0$ and a right boundary $R=length($`nums`$)$
2. Initialize a middle pointer $M = (L + R) / 2$
3. If the value at index $M$ is ever equal to `T`, return $M$; otherwise shrink $L$ or $R$ accordingly
4. If no value is equal to `T`, return $-1$

## Implementation



### Variation 1: Return Early
```python
def search(self, nums: List[int], target: int) -> int: 
    left, right = 0, len(nums)-1

    while left <= right:
        mid = (left + right) // 2
        
        if nums[mid] == target:
            return mid
        elif nums[mid] > target:
            right = mid - 1
        else:
            left = mid + 1

    return -1

```

### Variation 2: Return After Exiting
```python
def search(self, nums: List[int], target: int) -> int:
    left, right = 0, len(nums)-1
    
    while left < right:
        mid = (left + right) // 2
        
        if nums[mid] >= target:
            right = mid
        else:
            left = mid + 1
            
    return left if nums[left] == target else -1
```
## Analysis

### Time Complexity

$O(logn)$: In the worst case, there are $O(logn)$ comparisons made where $n$ is the number of array elements. The entire array will be searched, where half the array is discarded after every iteration.

###  Space Complexity

$O(1)$: There are no additional data structures used.

## Explanation

While the overall algorithm is straightforward, binary search's implementation can be tricky due to different edge cases and variations. The following sections were heavily inspired by this [Leetcode discussion](https://leetcode.com/problems/binary-search/discuss/423162/Binary-Search-101).

### Left/Right Boundaries

When searching for a target in a sorted array, these pointers are almost always initialized as:
```python
left, right = 0, len(nums) - 1
```
However, both pointers must cover the **entire** search space. If the problem was instead ["Find the insert position"](https://leetcode.com/problems/search-insert-position/), it is possible to insert after the last element. In this case, the boundaries would be initialized as:
```python
left, right = 0, len(nums)
```
### Middle Pointer Calculation

The standard middle pointer calculation is:
```python
mid = (left + right) // 2
```
However, there are two subtleties to consider: overflow and even middle selection.

**1. Overflow**

Languages with signed integers (ie. Java, C++) have the possibility of overflowing from arithmetic operations. To circumvent this, the following calculation can be used instead:
```python
mid = left + (right - left) // 2
```
**2. Even Middle Selection**

In arrays with an even number of elements, there are two possibitilies for the "middle" element; it can either be the element on the middle left or the middle right.
```python
mid = left + (right - left) // 2
       |
[1, 2, 3, 4, 5, 6]
          |
mid = left + (right - left + 1) // 2
```
This selection will directly affect how the boundaries should be shrunk, as the wrong choice can lead to an infinite loop.

### While Loop Condition

Two common options for the while loop condition are `while l <= r` and `while l < r`.

**1. `while l <= r`**

This should be used **when the result is returned from inside the loop**. The termination condition is when `l > r`, which signifies that the array does not contain the target. Note that this may not apply to all questions, as not all problems involve searching for the existence of a target.

**2. `while l < r`**

This should be used **when the result is returned from outside the loop**. The termination condition is when `l == r`, which signifies when the loop exits that the two boundaries point to the same value, presumably the target.

### Shrinking the Boundaries

Shrinking the boundary will depend on whether the value at the current index is greater or less than the target. If the value is greater, then that means the target is guaranteed to be on its left (since the array is sorted), so the right boundary is moved. If the value is less than the target, then the target will be on its right, so the left boundary is moved.

There are two possibilities to consider when shrinking the boundaries - whether to include the middle pointer or not. **This will depend on both the middle pointer calculation and the conditional check prior to the boundary move**.

Assuming a while condition of `l < r`, the following would **not** work:
```python
mid = left + (right - left) // 2        # this line is incorrect

if nums[mid] > target:                  # given this condition
    right = mid - 1
else:
    left = mid
```
This can be fixed by changing the conditional to include the target value:
```python
mid = left + (right - left) // 2

if nums[mid] >= target:                 # correct
    right = mid - 1
else:
    left = mid
```
Or by rounding the middle pointer up during its calculation:
```python
mid = left + (right - left + 1) // 2    # correct

if nums[mid] > target:               
    right = mid - 1
else:
    left = mid
```
A trick to easily verify if the middle pointer calculation and boundary shrinking logic are correct is to visualize how it would behave on an array with two elements. If the logic is incorrect, then the boundaries won't move which will result in an infinite loop.

## Variations

- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [Find Minimum in Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Find Minimum in Sorted Array with Duplicates](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/)
- [Search in a 2D Matrix](https://leetcode.com/problems/search-a-2d-matrix/)
