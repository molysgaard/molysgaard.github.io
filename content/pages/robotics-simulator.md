---
title: Robotics Simulator
---

# Introduction
One of the main challenges with developing drones, is the amount of physical testing required. Back in 2015-2016 when we were in the most intense period of development of the Staaker drone, I realized that if we could make our testing and verification more effective, we could improve our development speed drastically. This spawned the simulator project.

# Some features I implemented
- **Architecture:**
    - Focus separation between rendering and simulation/physics.
    - Rolled our own C++ entity component system system.
- **Rendering engine:** Filament physically based renderer, after a survey spanning everything from Unreal to Ogre 3D.
- **Physics motor:** developed from scratch in C++ using Eigen.
    - Very accurate integration of multirotor ODEs using Runge-Kutta methods for linear parts and quaternion exponential maps for orientation.
    - As a proof of concept I integrated DART physics motor, but as we are flying, we did not have that much use for its advanced support of contacts.
    - Ended up just rolling my own rudamentary collision simulation.
    - Would integrate DART or similar if advanced collision handling was needed.
- **<a href="#ci">Continuous integration:</a>**
    - Developed a domain specific language for specifying flight scenarios.
    - Very flexible language, executed by the simulator when run in test mode, able to express:
        - What to do, eg. a mission and its sub-steps
        - Abnormal behaviour, like suddenly removing a motor mid flight or receiving garbled gyro-data
        - What to check, arbitrary assertions that can be run at any time during the simulation, and that has ability to inspect the whole simulator state.
    - This language was used to create a large test suite, that was run on each commit software in the loop.
    - This made it possible to develop autopilot code changes with great confidence, and accelerated our development process enormously
- **<a href="#vis">Visualizations:</a>**
    - Colored point clouds
    - Voxelgrids
    - Marching cubes on smooth signed distance functions for arbitrary 3D terrain generation
    - 3D cubic splines
- **<a href="#sensors">Simulated sensors:</a>**
    - Gyroscope, accelerometer, barometer and magnetometer with realistic noise characteristics
    - GPS with a complex noise model simulating not just standard Gaussian noise
    - RGB cameras, available for visual navigation algorithms
    - Depth cameras, available for visual navigation algorithms
    - LIDAR, rudamentary simulation, available for navigation algorithms

# Continous integration{#ci}
TODO

# Visualizations{#vis}
TODO

# Simulated sensors{#sensors}
TODO Add video here showing the 