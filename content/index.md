---
title: Sample projects
---

<details>
<summary><a href="/pages/robotics-simulator.html"><span class="detail-header">Robotics Simulator</span>

<video style="max-width:70%; max-height:70%;" autoplay="true" muted="true" loop="true">
<source src="/files/videos/robot-simulator/robot-simulator-gps-noise.webm" type="video/webm">
<source src="/files/videos/robot-simulator/robot-simulator-gps-noise.mp4" type="video/mp4">
</video>

One of the main challenges with developing drones, is the amount of physical testing required. Back in 2015-2016 when we were in the most intense period of development of the Staaker drone, I realized that if we could make our testing and verification more effective, we could improve our development speed drastically. This spawned the simulator project.
</a></summary>
In day to day development the simulator is your source of truth. 

<h3>Some features I implemented</h3>
- Overall architecture.
    - Focus separation between rendering and simulation/physics.
    - Rolled our own C++ entity component system system.
- Choice of rendering engine, Filament physically based renderer, after a survey spanning everything from Unreal to Ogre 3D.
- Physics motor, developed from scratch in C++ using Eigen.
    - Very accurate integration of multirotor ODEs using Runge-Kutta methods for linear parts and quaternion exponential maps for orientation.
    - As a proof of concept I integrated DART physics motor, but as we are flying, we did not have that much use for its advanced support of contacts.
    - Ended up just rolling my own rudamentary collision simulation.
    - Would integrate DART or similar if advanced collision handling was needed.
- Continuous integration:
    - Developed a domain specific language for specifying flight scenarios.
    - Very flexible language, executed by the simulator when run in test mode, able to express:
        - What to do, eg. a mission and its sub-steps
        - Abnormal behaviour, like suddenly removing a motor mid flight or receiving garbled gyro-data
        - What to check, arbitrary assertions that can be run at any time during the simulation, and that has ability to inspect the whole simulator state.
    - This language was used to create a large test suite, that was run on each commit software in the loop.
    - This made it possible to develop autopilot code changes with great confidence, and accelerated our development process enormously
- Visualizations: 
    - Colored point clouds
    - Voxelgrids
    - Marching cubes on smooth signed distance functions for arbitrary 3D terrain generation
    - 3D cubic splines
- Simulated sensors:
    - Gyroscope, accelerometer, barometer and magnetometer with realistic noise characteristics
    - GPS with a complex noise model simulating not just standard Gaussian noise
    - RGB cameras, available for visual navigation algorithms
    - Depth cameras, available for visual navigation algorithms
    - LIDAR, rudamentary simulation, available for navigation algorithms
- Hardware in the loop simulation
- Software in the loop simulation

<!--
<h3>Motivation</h3>
The goal of the project was simple. We were able to test our system between 1 and 3 times a day by going out doing field tests. If we had a crash, it usually cost us a day of repairs before we were ready to test again. If the weather was too bad, we could not do tests. I estimate that between 1/2 and 2/3 of our time was lost in overhead related to field testing and repairs.

My vision was to be able to test our drones, like most software is tested. Write, compile, run and inspect, repeat. Each developer should be able to do
10-50 test every day, independently of each other, and without the fear of crashing.

It was clear that we needed a simulator, and it would need to be a rich simulator, not just some python scripts creating some plots.

<h3>Graphics</h3>
I used some time to find the sweet spot for the graphics. I tried full fledged game engines, like Unreal, but it was to all-encompassing to easily integrate like we would like.
Then we tried simple 3D motors like Ogre 3D, but it did not render anything that looked like real images.
We were simulating visual navigation, depth vision, LIDAR and similar, Ogre would not cut it.
In the end, we settled for a then prototype library, which since has become very mature. The Filament physically based rendering engine.
It was the perfect sweet-spot. It is a C++ library, not a software platform, it renders with very high realism, the biggest limit on realism
is the amount of work put into the scenes, and not the rendering engine itself.

<h3>Software architecture</h3>
For overall software architecture, we chose to implement our own entity component system. This is common in the game engines, and
it fit great for our use case as well.

<h3>Simulation of gyroscope, accelerometer, barometer, magnetometer and GPS</h3>
To simulate a sensor, it is important to understand the stochastics of the signal.
For the gyroscope, accelerometer, barometer and magnetometer it is relatively easy to get a 
lower bound for the noise you can expect by simply capturing a time series from the sensor while it is
on your desk.
In reality, I had to estimate far larger values for noise than this, because on a real drone system
there is vibrations, electromagnetic interference, radio noise etc.
For realistic values, I had to create a setup that faked flying well enough, for each sensor, and
then capture a time series from this.

Lastly, there is GPS. To not get too specific, for GPS I had to develop a considerably more
complex error model than for the other sensors, because GPS is a much more complex sensor system, with a lot more
physics affecting the measurement. 

<h3>Software and hardware in the loop simulation</h3>
Our autopilot system was architected around our own in-house, hard-real-time message-passing system.
A bit like a statically typed, hard-real-time ROS message system.
All the different tasks running on the drone would coordinate and communicate using these messages, and there was no
shared data other than message passing.

This meant that when we wanted to do simulation of our stack, it was in really easy.
Create a special message, that when the drone receives it, silences the sensor drivers. They are still running, but when
they want to publish new sensor readings, they simply skip the publication step.
Then inject simulated sensor readings with the appropriate noise and real-time characteristics to the autopilot instead,
and the autopilot now behaves just as if it was reading real sensor readings.

For software in the loop simulation, we created a hardware abstraction layer for our autopilot software that made it run on Linux.
We then ported our message passing system so that it would also be able to run on Linux.
With these two components in place, running our autopilot on Linux, and talking trough it using message passing was as easy as publishing and subscribing
to the right messages from in our simulator.

For hardware in the loop simulation we chose to use a direct serial connection with the drone which we could use to send serialized messages from our message passing system over.
This way, our simulator could send and receive messages from the autopilot with a rate of 1000Hz and a jitter of less than 1ms.
-->

</details>

<details>
<summary><a href="/pages/trajectory-optimization-toolbox.html"><span class="detail-header">Trajectory optimization toolbox</span>
<video style="max-width:70%; max-height:70%;" autoplay="true" muted="true" loop="true">
<source src="/files/videos/multicopter-trajectory-optimization.mp4" type="video/mp4">
</video>

I have had a long fascination for trajectory optimization. It started back in 2016 when I was researching better ways to handle actuator saturation for drone control systems while developing the Staaker Drone.
</a>
</summary>
</details>

<details>
<summary><a href="/pages/autonomous-rail-landing.html"><span class="detail-header">Autonomous landing on railways tracks</span>
<video style="max-width:70%; max-height:70%;" autoplay="true" muted="true" loop="true">
<source src="/files/videos/robot-simulator/robot-simulator-rail-landing.webm" type="video/webm">
<source src="/files/videos/robot-simulator/robot-simulator-rail-landing.mp4" type="video/mp4">
</video>
</a>
</summary>
</details>

<details>
<summary><span class="detail-header">The Staaker Drone state estimator</span>

For the Staaker and Nordic Unmanned drones, I designed and implemented the state estimator. The design is an flexible extended kalman filter, running hard real-time on an STDM32F4. I estimates all states of the drone at 500Hz.</summary>

<h3>General design</h3>
The Staaker Drone uses an extended kalman filter as its state estimator.
The state contains position, velocity, acceleration, attitude modelled as a quaternion and 3-axis gyro-bias.
The control input tho the filter is the gyroscope and body frame accelerometer measurements.
The kalman filter supports several different types of measurements (kalman updates):

1. World-frame-yaw heading
2. Body acceleration
3. Combinated body acceleration north-east heading
4. Altitude measurement (barometer or GPS-height)
5. Combined GPS-north-east-position, altitude, NorthEastDown-velocity, body-acceleration and word-frame-yaw heading

The reason for this many types of measurements is that data arrives at different rates.
The sensors are ordered from slowes to fastes:

- GPS: 5-10Hz, not hard-real-time timing
- Barometer/compass: ~20Hz sampling
- Accelerometer/gyroscope: 500Hz sampling

At each update of the kalman filter, the readyness of new sensor data is checked for each sensor.

- If GPS data is available, the most expensive and full update step is run, 5.
- Else if magnetometer data is available, update 3. is run
- If barometer data is available, update 4.
- Last, if accelerometer data is available, and it has not yet been "consumed" by any of the other update steps, update 2. is run.

With this design, the kalman filter can estimate and integrate data from all the different sensors, in a consistent manner, at the highest possible rate, 500Hz, without
having to to hacks like having an integrating observer running ahead in time of the kalman filter.

A critical point in the design of any kalmin filter that contains attitude is how to parametrize it.
In my work I have choosen that the kalman filter estimates a linearized 3-axis error angle, of the current non-linear quaternion state. This is different from linearizing the quaternion equations and directly estimating the next 4 quaternion coordinates. 
The reason for this is that attitude-quaternions require that $|q|=1$, which is
a constraint the kalman filter is not able to take into account.
This means that any extended kalman filter which is estimating directly an quaternions, DCM-matrices or similar will end up estimating poorly, especially for very dynamic systems, as the extended kalman filter ends up with an estimate where $|q|\ne1$.

<h3>Software implementation</h3>
The kalman filter is required to run at 500Hz on a tiny STM32F4 chip.
A normal naive implementation in C++ would have a hard time getting close to just 50Hz update rate on such a processor.
To enable this fast enough numerics on such a small computing budget, I developed
an optimizing symbolic math based numerical compiler in Python using SymPy.
The compiler takes as input the symbolic equations for the movement of a drone, and outputs a C-file, containing no dynamic memory, no loops, no unbounded control logic.
One of the key innovations for this was to find a general closed form solution for the covariance update step in the kalman equations and compressing this expression down to a code size that quickly will execute on a microcontroller.

The compiler is fully integrated into the drone build system, so chaning any of the declarative model-input files triggers a full rebuild of the whole kalman filter stack.
</details>

<details>
<summary><span class="detail-header">The Staaker Drone control system</span>

For the Staaker and Nordic Unmanned drones, I designed and implemented the control system. The design is a classic cascaded PID-loop design, with a complex mapping between desired accelerations and desired attitude. The control stack is running hard real-time on an STDM32F4. I consumes estimates and refernce setpoints and controls the drone motors at 500Hz.</summary>

<h3>General design</h3>
The Staaker drone control system is a classic cascaded PID design.
For position, the implementation is straight forward.
For velocity, if saturation is reached, a heuristic prioritizing altitude is used. This saves the drone from crashing into the ground if it is given velocity setpoints it can not reach.
Acceleration is mapped to orientation and thrust, by solving the physical model of the forces on the craft for orientation.
Orientation uses a a nonlinear control law. It takes into account that roll and pitch moments are much easier to generate than yaw.
It also takes into account the existing momentum of the craft.
The generated rate setpoint from the orientation control law is used by the rate PID controller.

<h3>Motor saturation handling</h3>
Quadcopter controller design would be easy, if it wasn't for saturation. The reason is that in the control system, information flows from the slow dynamics, to the fast dynamics. Position -> velocity -> attitude -> rates -> motor setpoints.
First when some motor setpoints have been computed, you will know if any of the motors will saturate.
If none of the motors saturate, you now have the problem of propagating backwards trough the control laws the saturation, trying to change the setpoints so that the saturation disappears.

In the Staaker drone, yaw-rate is always sacrificed first, if saturation is detected. This is because a quadrotor can fly safely as long as it is able to measure its yaw, while it does not need to control it. A fascinating example of this is in this video:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/t369aSInq-E?start=14" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

</details>

<details>
<summary><span class="detail-header">Nordic Unmanned Railway Robot Phase 1</span>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/srBggRXdrAM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

This project was an initial technical demonstrator.
The goal was to create a drone platform that is physically capable of driving on rails and flying, as well as landing on them.
</summary>

<h3>Drone platform</h3>
For the drone platform, our BG200 platform was adapted.
Here my responsibility was an ensuring the following properties of the platform

- Flight characteristics able to land.
- Flight endurance to be be able to jump between tracks many times.
- Rail driving endurance of >100km.
- Feasible placement for all avionics, computer vision and onboard computing systems
- Compromize between fligth and rail running performance

As the project had constraints, we could not change the BG200 frame design, only add to it.
The end result is a carefull compromize between all the performance factors, complexity and cost.
</details>

<!--details>
<summary>
<span class="detail-header">The Staaker Drone embedded system architecture</span>
The Staaker Drone Autopilot system runs on an embedded MCU, on STM32F4/STM32F7.
As CTO in The Staaker Company, and VP Software & Systems Engineering in Nordic Unmanned,
I both oversaw the overall design and architecture of our embedded system.
</summary>

<h3>Overall architecture</h3>
When starting The Staaker Company, we decided for using C++ as our main language.
</details-->

<details>
<summary><span class="detail-header">High efficiency low-latency live video streaming</span>
To control a drone, an operator depends on a live video stream. I designed and implemented the software stack that does videostreaming in Nordic Unmanneds Staaker drones.</summary>

<h3>General design goals</h3>
Key design goal for the video streaming stack was the following:

- Low end-to-end latency. From the camera grabs a frame untill it is visible on the screen on the ground, there should be no more than 60-70ms for the operator to feel he still has control of the craft.
- Low bandwith. Long range together with maximum power requirements on radio equipment means that the received signal from the drone is weak. This leads to a low maximum bandwidth. We optimized or systems to carry 2 video streams within 1.5megabit of bandwith.
- High tolerance to network packet loss
- High tolerance to network packet jitter
- High energy/compute efficiency

<h3>Implementation</h3>
To get low end-to-end latency, there can be very few buffers in the pipeline.
The only places where data is buffered in the solution is inside the video encoder, which requires at least 1 single frame delay to be able to do delta encoding, and withing the reciving jitterbufer, that handles network packet reordering. Another critical part of the latency was to use hardware accelerated encoding and tune the encoder for minimal latency.

To get the required energy/compute efficiency using VA-API was choosen. This offloads the hard work of H264 video encoding to the underlying graphics hardware.

To handle network packet jitter, a jitterbuffer was used on the receiver side. To handle packet loss, additional forward error correction coding is used on the sender side, and the accompanying FEC-decoding on the reciving side. This lets the link handle X% packet loss, at the cost of X% extra bandwidth, without any loss of information on the receiving side.

The system was implemented in the Rust programming language, using the gstreamer library.
</details>

<details>
<summary><a href="/pages/numerical-solvers.html"><span class="detail-header">Linear systems and NLP solvers</span>
</a></summary>
</details>

<details>
<summary><a href="/pages/kontrol-lang.html"><span class="detail-header">Programming language design and implementation</span>
</a></summary>
</details>

<!--details>
<summary><span class="detail-header">Long Range Mesh Radio system</span>
For several of our missions in Nordic Unmanned. Dedicated long range radio links are required. These are used for streaming live data down to the operator as well as controling the drone. I have worked with the selection, testing and verification of the radio system we used.</summary>

<h3>Specification</h3>

<h3>Testing and verification</h3>
</details-->

<!--details>
<summary><span class="detail-header">Nordic Unmanned RailRover</span>
todo
</details-->


<!--
# Skills TODO
- Software architecture
- Numerical analysis
- Mathematical modeling, physics, and simulation
- Estimation and control
- Hardware and software in the loop simulation
- Library development
-->
