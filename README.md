# Algorithm Visualizer

This repository is to visualize how some pathing algorithms work. This project is not only to display my progress while learning Ruby, but also to simply show how some algorithms choose their path to an end goal!

## Functionality

### Display of Heuristic

The darkness of the block is dependant on the manhattan distance from that block to the goal.

![Example 1](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_4.png)

### Path Information

When the path from the start to goal is caluclated then a green block is drawn for each block taken. A number is overlayed onto each block to show the step number.

![Example 2](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_5.png)

### Adding Obstacles

A left click on any of the squares will produce a border that the path cannot traverse. This is where the algorithm will have to calculate a new path around the obstacle.

![Example 3](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_6.png)

## A* Algorithm

### Optimal Path

Here we can see that the algorithm is going to find the optimal path using heuristics. 

![Example 3](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_1.png)

### Semi-Optimal Path

Here we can see a semi-optimal path. The algorithm implementation isn't working as planned and the path isn't as efficient as it could be.

![Example 4](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_2.png)

### Sub-Optimal Path

Here we can see a sub-optimal path. The algorithm definitely needs revision at this point.

![Example 5](https://github.com/IrishFagan/AlgorithmVisualizer/blob/master/images/Screenshot_3.png)

## Tech Used
[Ruby 2D](https://www.ruby2d.com/)