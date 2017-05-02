# SwarmAlgorithms
Algorithms developed to make drone swarm move together and strive not to collide with each other.

## Notes on Algorithms
- This project was based on constraints set by other individuals
- In all cases, the swarm maneuvers to a target location via the use of a Cost Function that is minimized as they get closer to the goal location
- To minimize the cost, a form of Gradient Descent and a Particle Swarm Optimization are options one can use
- To avoid collisions with each other and obstacles, high cost regions are centered at each particle/obstacle to help the swarm avoid these areas via the optimization
- The way the problem is formulated and solved, it is possible for the swarm to get stuck in local minimums of the cost function.
  - In these events, it could be a fix to use a discrete approach like a graph algorithm treating the cost function as a way of weighting each path and then solving the problem using an approximate Traveling Salesman approach. This will have to be future work.
