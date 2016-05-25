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


