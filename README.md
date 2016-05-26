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

> write a version of limited_infection that infects exactly the number of users specified and fails if that’s not possible (this can be (really) slow)

The first statement and the optional task to do taken together suggested to me two necessary operations for the ideal: finding connected components so we can get their size (number of nodes, vertices, users), and an operation to find the connected component sizes summed closest to our target. This reminded me a bit of the knapsack problem or k-sum. After thinking on it a bit, I figured it matches the [subset sum problem](https://en.wikipedia.org/wiki/Subset_sum_problem), which is NP-complete.

> Implement a procedure for limited infection. You will not be penalized for interpreting the specification as you see fit. There are many design choices and tradeoffs, so be prepared to justify your decisions.

The procedure for limited infection then has 2 parts: 1. finding all connected components of a graph and getting its size, 2. using a set of the connected component sizes as integers, find a subset that matches the target number most closely. 1. is an extension of the solution to total infection, to my mind, because we just need to call a Breadth-First or Depth-First search on every vertex, checking as we go that we're not repeating one. In the interest of time then I'm going to focus on 2, by pretending I already have the set of component sizes I need, and implement a method for finding the subset sum from that set.
