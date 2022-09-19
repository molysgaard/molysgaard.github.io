---
title: Autonomous Rail Landing
---

# Demo video
This video demonstrates the simulation of the full rail landing stack in 
the [Robot Simulator](/pages/robot-simulator.html).
The blue markers are points that the tree-RANSAC clasifier flags as part of a rail,
the red markers are all other points.

The landing controller first positions the drone between the rails,
then it starts while keeping control of its yaw.
Everything using the 3D point cloud data as input.

<video style="max-width:70%; max-height:70%;" autoplay="true" muted="true" loop="true">
<source src="/files/videos/robot-simulator/robot-simulator-rail-landing.webm" type="video/webm">
<source src="/files/videos/robot-simulator/robot-simulator-rail-landing.mp4" type="video/mp4">
</video>

# Introduction
The goal of this subproject was to demonstrate that a drone can:

- Autonomously navigate to a rail.
- Localize the rail using local vision sensors.
- Plan and execute a smooth track-landing using local vision sensors.

To ease the development, a 500mm size drone was used as a research vehicle.
The tech stack was the following:

- 500mm size drone
- Staaker Autopilot
- Small onboard ARM64 Linux computer
- Intel RealSense stere depth camera for visual input data

The vision, estimation and control stack was fully implemented by me, and consisted of the following C++ pipeline.
The RealSense camera would be configured for minimal latency and filtering.
A custom C++ RANSAC library was developed, and hand tuned for 20Hz performance on a very weak ARM64 linux single board computer.
Using the RANSAC library, I designed a chain of RANSAC filters to isolate the rails from all the other points in the pointcloud with very high robustness, low latency, and 20Hz throughput.
Because the method was purely based on the geometry of the rails, it was extremely robust to common issues with vision systems. It would easily handle any visual changes like lighting conditions, varying degrees of rust, leaves on the track etc. Since it was based on RANSAC filtering, the algorithm was also very robust against noise in the point cloud data, things like shrubs, leaves, straws, signpoles etc. would not confuse the filter.

Using 3D transformations the Linux computer would continuously produce a stream of 3D-point-pairs, which represented the current position of the rail in the drones body frame.
This stream would then be feed into a custom rail-landing control system. This system would home the drone on the rail, and a control law would lower the drone carefully, while maintaining contol of x,y-position and yaw. The control law was designed to be robust in such a way that if the drone was divering from its planned path, it would ascend untill it's margin for error was large enough to retry.

The control signal from the rail-landing controller would be feed as low level NED-velocity commands to the Staaker Autopilot system.
And the Staaker Autopilot system would execute these using its control system to safely land.

# Simulation
To develop visual navigation algorithms with confidence, I build a simulation of the landing task in our simulator.
It leverages custom shaders to generate a simulated RealSense depth camera, which is then feed trough the same software stack that runs on the real drone.
The control signal from the software stack is then feed back into the simulator, to complete the loop.

In the video you can se the ground truth drone (white drone), estimated position (red drone), and estimated position and orientation (green).
You can see a point cloud underneath the drone. The tree of RANSAC classifiers is used to colorize the points to blue if they belog to the rail,
and red if they do not.
Simulations like this are invaluable during development. To be able to visualize how the robot is thinking, is key to develop a good robotics systems.