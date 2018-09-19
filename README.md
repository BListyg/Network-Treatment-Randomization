# Network-Treatment-Randomization

The inspiration for this code came as a result of independent studying I've been doing on how to conduct randomized control trials (RCTs) on a social network. I found that combining the `igraph` package with the `randomizr` package leads to insightful visualizations of treatment assignment within a graph of disconnected components of varying sizes.

This R code provides visualizations for 3 separate randomization strategies within an undirected component graph. The graphs this code produces differ than those discussed in the exisiting literature on network experiments (e.g. Athey, Eckles, and Imbens, 2015) due to the fact that there is independence / non-interference between each graph component / sub-graph. With this in mind, there is no need for any type of complex graph partitioning algorithm (e.g. the normalized edge cut) to separate the network in such a way that minimizes unit interference.

Treatments can be applied to:

* Edges
* Nodes
* Components
* Any combination of the 3 above (in the case of visualizing interaction effects)

![](https://i.imgur.com/v876dTL.png)
