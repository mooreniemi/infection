# infection

## installation

```
gem install bundler # assuming you have a system Ruby available
bundle install # at same level as this README
```

## running tests

```
rspec
```

## total infection

> We can use the heuristic that each teacher-student pair should be on the same version of the site. So if A coaches B and we want to give A a new feature, then B should also get the new feature. Note that infections are transitive - if B coaches C, then C should get the new feature as well. Also, infections are transferred by both the “coaches” and “is coached by” relations.

I took the last sentence to mean that the graph is undirected, because it seems the same as this definition: "[when] edge (x, y) is an element of E, implies that (y, x) is also in E". I found this phrasing a little confusing at first though, so I might be wrong.

> First, model users (one attribute of a user is the version of the site they see) and the coaching relations between them. A user can coach any number of other users. You don’t need to worry about handling self-coaching relationships.

I interpreted the last sentence to mean it is a _simple_ graph, because if it had self-coaching it would have self-loop edges. Otherwise this seems like for my first pass, I can model users as nodes with just one piece of information in them: a version number.

> Now implement the infection algorithm. Starting from any given user, the entire connected component of the coaching graph containing that user should become infected.

This reads like a straight-forward exhaustive graph traversal to me, so my first impulse is a Breadth-First Search. We know based on a given graph and some vertex on it, we can find all the other vertices.

## partial infection

> We would like to be able to infect close to a given number of users. Ideally we’d like a coach and all of their students to either have a feature or not. However, that might not always be possible.

So, first I sort of considered how in the ideal case we could get the result. I figure it requires two necessary operations: 1. finding connected components so we can get their size (number of nodes, vertices, users), and 2. an operation to find the connected component sizes summed to our target (if there are any). This reminded me a bit of the knapsack problem or k-sum. After thinking on it a bit, I figured it matches the [subset sum problem](http://nerderati.com/2014/08/19/bartering-for-beers-with-approximate-subset-sums/), which is NP-complete.

Given the constraint on coaching relationships is loose, and an approximate seems acceptable, I looked for an approximate solution that behaves well. The naive solution to subset sum is exponential (O(2^N)) because you'd be iterating over a po-set (every possible combination). But an approximate gets us to linear time. Nice! :)

Technically, the approximate algorithm can give us the exact one for free, but as I said it performs exponentially. So in the optional problem I actually tried to do a bit better than that.

> write a version of limited_infection that infects exactly the number of users specified and fails if that’s not possible (this can be (really) slow)

To get an exact solution in better than exponential time, I tried an implementation of a dynamic programming algorithm for subset sum. This gives us psuedo-polynomial time, which is still pretty darn slow for large numbers. One thought I had was if we had roundable numbers, we could scale our numbers to get better performance. This comes at the cost of not having exact solutions for numbers like 23423.

I ended up solving approximate and exact implementations in the opposite order (I did the exact one first), out of my own curiosity in dynamic programming. I wouldn't usually do things out of priority order during normal working time, but I gave myself a break on this exercise.

