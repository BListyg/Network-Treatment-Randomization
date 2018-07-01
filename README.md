# Network-Treatment-Randomization

The inspiration for this code came from background research I did in preparation for a tech talk I gave to my company recently. 

Accompanying preparation for the talk, I've separately been interested in recent work by Susan Athey, Dean Eckles, Johan Ugander, and many other researchers on how to perform randomized control trials (RCT) within social networks.

This R code provides visualizations for 3 separate randomization strategies within an undirected graph. The graphs this code produces differ than those discussed in the aforementioned literature due to the fact that there is independence / non-interference between each graph component / sub-graph. With this in mind, there is no need for any type of complex graph partitioning algorithm to separate the network in such a way that minimizes this unit interference.

Treatments can be applied to:

* Edges
* Nodes
* Components
* Any combination of the 3 above (in the case of visualizing interaction effects)

![](https://i.imgur.com/v876dTL.png)
