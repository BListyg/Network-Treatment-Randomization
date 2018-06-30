#Importing Libraries
library(igraph)
library(randomizr)

#Creating not in function to eliminate loops
'%!in%' <- function(x,y)!('%in%'(x,y))

#Specifying number of tutors
n_tutors <- 200

#Creating tutor ids
tutor_id <- sort(sample(x = c(1:n_tutors),size = n_tutors,replace = T))

#Creating students ideas that are NOT IN tutor id
#These have to be mutually exlusive
student_id <- c(1:n_tutors+length(tutor_id))[c(1:n_tutors+length(tutor_id)) %!in% tutor_id]

#Combining students and tutors
d.f <- data.frame(
  tutor_id,
  student_id)

#Creating a graph object from the previous made edgelist
tutor_g <- graph_from_data_frame(
  d.f,
  directed = F
)

#####

#Empty list for component treatment assignments
component <- list() 

for(i in 1:length(components(tutor_g)$csize)){
  component[[i]] <- rep(i,components(tutor_g)$csize[i]-1)
}

d.f$component <- unlist(component)

#

component_treatment <- list()

for(i in 1:length(components(tutor_g)$csize)){
  component_treatment[[i]] <- rep(simple_ra(N = length(tutor_id))[i],components(tutor_g)$csize[i]-1)
}

d.f$component_treatment <- unlist(component_treatment)

#####

# tutor_treatment <- list()
# 
# for( i in 1:length(melt(table(d.f$tutor_id))$value )){
#   tutor_treatment[[i]] <- rep(simple_ra(N = length(unique(d.f$tutor_id)))[i],
#             melt(table(d.f$tutor_id))$value[i])
# }
# 
# d.f$tutor_treatment <- unlist(tutor_treatment)

#####

# student_treatment <- list()
# 
# for( i in 1:length(melt(table(d.f$student_id))$value )){
#   student_treatment[[i]] <- rep(simple_ra(N = length(unique(d.f$student_id)))[i],
#             melt(table(d.f$student_id))$value[i])
# }
# 
# d.f$student_treatment <- unlist(student_treatment)

#####

d.f$edge_treatment <- simple_ra(N = nrow(d.f))

#####

d.f$component_treatment <- d.f$component_treatment+1

# d.f$tutor_treatment <- d.f$tutor_treatment+1
# 
# 
# d.f$student_treatment <- d.f$student_treatment+1

d.f$edge_treatment <- d.f$edge_treatment+1

###

node_treatment<-cbind(c(1:length(V(tutor_g))),simple_ra(N = length(V(tutor_g)))+1)

###

tutor_treatment <- cbind(unique(d.f$tutor_id),simple_ra(N = length(unique(d.f$tutor_id))))

tutor_treatment[,2] <- tutor_treatment[,2] + 1

###

student_treatment <- cbind(unique(d.f$student_id),simple_ra(N = length(unique(d.f$student_id))))

student_treatment[,2] <- student_treatment[,2] + 1

###

final_data <- list(data=d.f,
                   node_treatment = node_treatment,
                   tutor_treatment = tutor_treatment,
                   student_treatment = student_treatment)

###
#Nothing
par(mfrow=c(2,2))

plot(tutor_g, vertex.size=8, vertex.label=NA, vertex.color='gray',edge.width=4,vertex.shape='circle',edge.color='black', main='Component Graph\nUntreated',margin=-0.1,cex.main=3)

###
#Component Level Randomziation
E(tutor_g)$comp_treatments <- d.f$component_treatment
edge.color = c('blue','green')[E(tutor_g)$comp_treatments]

plot(tutor_g, vertex.size=8, vertex.label=NA, vertex.color='gray',edge.width=10,vertex.shape='circle',edge.color=edge.color, main='Component Graph\nRandomization @ Components',margin=-0.1, vertex.label.size=6,cex.main=3)

###
#All Nodes
V(tutor_g)$color[V(tutor_g) %in% final_data$node_treatment[,1][which(final_data$node_treatment[,2]==1)]] <- 'indianred'
V(tutor_g)$color[V(tutor_g) %in% final_data$node_treatment[,1][which(final_data$node_treatment[,2]==2)]] <- 'lightblue'

plot(tutor_g, vertex.size=8, vertex.label=NA,edge.width=7,edge.color='black', main='Component Graph\nRandomization @ Nodes',margin=-0.1,veretx.shape=NA, vertex.label.size=6,cex.main=3)

###

E(tutor_g)$edge_treatment <- NA
E(tutor_g)$edge_treatment <- d.f$edge_treatment
edge.color = c('gold','turquoise')[E(tutor_g)$edge_treatment]

plot(tutor_g, vertex.size=8, vertex.label=NA, vertex.color='gray',edge.width=10,vertex.shape='circle',edge.color=edge.color, main='Component Graph\nRandomization @ Edges',margin=-0.1, vertex.label.size=6,cex.main=3)

###
###

# V(tutor_g)$color[V(tutor_g) %in% final_data$student_treatment[,1][which(final_data$student_treatment[,2]==1)]] <- 'indianred'
# V(tutor_g)$color[V(tutor_g) %in% final_data$student_treatment[,1][which(final_data$student_treatment[,2]==2)]] <- 'beige'
# 
# edge.color = c('lightblue','lightgreen')[E(tutor_g)$comp_treatments]
# 
# # edge.width = c(4,20)[E(tutor_g)$edge_treatment <- d.f$edge_treatment]
# 
# V(tutor_g)$shape[V(tutor_g) %in% final_data$node_treatment[,1][which(final_data$node_treatment[,2]==1)]] <- 'square'
# V(tutor_g)$shape[V(tutor_g) %in% final_data$node_treatment[,1][which(final_data$node_treatment[,2]==2)]] <- 'circle'
# # 
# # V(tutor_g)$tutor_treatment<-d.f$tutor_treatment


###

cbind(
  apply(d.f[,c(4,5)], 2, table),
  table(unique(cbind(d.f$tutor_id,d.f$component_treatment))[,2]),
  table(unique(cbind(d.f$student_id,d.f$component_treatment))[,2]),
  table(final_data$node_treatment[,2])
  )


