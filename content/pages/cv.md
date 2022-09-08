---
title: CV
---

# Skills:
* C++
* Rust
* Software architecture
* Embedded development
* Linux systems programming
* Numerical analysis
* Mathematical modelling, physics, and simulation
* Estimation and control
* Hardware and software in the loop simulation
* Continuos integration
* Library development

## Programming
I have been programming since i was 12 years old and bought a LEGO Mindstorms set.
I have programmed large complex systems in:

* Languages: Rust, C++, Python, Haskell
* Build systems: CMake, Make, Cargo, Meson
* VCS system: GIT
* CI: GitHub Actions / GitLab CI

I am a programming language nerd, and on my spare time I develop my own compilers for pure functional reactive programs in Haskell.
I am comfortable in just about any tech-stack, but as I have explored the world of programming I have found that
my mind is better at designing large systems using statically typed languages, so I prefer those for larger systems.
For smaller systems the added flexibility and velocity of a dynamic language often makes it the most sensible choice.

# Management

<details>
<summary>
<span class="detail-header">Recruiting</span>
As VP Software & Systems Engineering in Nordic Unmanned. I had the opportunity to build a dedicated drone development software team in our offices in Oslo.
</summary>

When moving over to Nordic Unmanned we had a single SW-developer, in addition to me. To the project deadlines in both internal and external projects, it was clear that we needed more software development manpower. I took the task of recruiting 3 additional software developers.
The recruitment pipeline was designed as follows:

* The job ads had a clear technical focus, emphasizing how much freedom, and responsibility the positions would give.
* The ads were marketed towards young talented developers with 2 years in the industry.
* A detailed questionnaire was created required to fill out for all applicants, this worked as a natural filter, as well as giving lots of insights into the candidate very early in the process.
* This application process made it quite challenging to apply if you did not have the right skills, but if you had the right skills, it would be quite easy to show it.
* Based on the applications, the signal to noise ratio was very good. Around 10% of the applicants were spot on and had great applications.
* All of these were interviewed, and out of them 3 applicants clearly stood out.
* After follow up interviews, background checks etc. they were hired.
* The whole process took 4 months, and had very low costs, as there were no recruiters to pay.
* The quality of the hires was very high, both on a technical level, but also on the ability to work together as a team.
* The salary expectations of the hires were average. The process was focused hiring people with 2 years in industry, that had jobs were they did not get out their potential.

When you are starting up a new department, company, or team, the initial hires are very important. This process worked remarkably well for creating a founding team.
It does not scale to recruiting a 100 engineers, but usually, when you are making something cutting edge, it is better with a few very good engineers, than a lot of mediocre ones.
</details>

<details>
<summary>
<span class="detail-header">Personnel responsibility</span>
As VP Software & Systems Engineering in Nordic Unmanned I had personnel responsibility for my team.
</summary>

During day to day work, I helped my team manage their work life balance. Personal issues etc.
I have experienced the effect of "just working hard" during the early days of The Staaker Company, and seen
what it does to the long term productivity of a team.
I believe that high performing teams, it is possible to give a lot of flexibility to the employees
without it being misused.
After all, they have chosen to work for this company and team themselves, among so many other exciting opportunities.
Give them flexibility, and they will be flexible and dedicated in return, when the job requires it.

Even flexibility has its limit. I have good experience with creating some clear frames for work,
so that developers know what is expected of them for each phase of the development.
</details>


<details>
<summary>
<span class="detail-header">Leading a team</span>
As VP Software & Systems Engineering in Nordic Unmanned I had the privilege to lead my team to our goals set by our CTO and our business and sales units.
</summary>

</details>

# Technical leadership

<details>
<summary>
<span class="detail-header">The Staaker Drone embedded system architecture</span>
The Staaker Drone Autopilot system runs on an embedded MCU, on STM32F4/STM32F7.
As CTO in The Staaker Company, and VP Software & Systems Engineering in Nordic Unmanned,
I both oversaw the overall design and architecture of our embedded system.
</summary>

<h3>Overall architecture</h3>
When starting The Staaker Company, we decided for using C++ as our main language.
</details>

# Technical projects
<details>
<summary><span class="detail-header">Nordic Unmanned Railway Robot Phase 1</span>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/srBggRXdrAM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

This project was an initial technical demonstrator. 2 goals were set:

1. Create a drone platform that is physically capable of driving on rails and flying, as well as landing on them.
2. Demonstrate an automated landing system that can land a drone on a rail autonomously.
</summary>

<h3>Drone platform</h3>
For the drone platform, our BG200 platform was adapted.
Here my responsebility was an ensuring the following properties of the platform

* Flight characteristics able to land.
* Flight endurance to be be able to jump between tracks many times.
* Rail driving endurance of >100km.
* Feasible placement for all avionics, computer vision and onboard computing systems
* Compromize between fligth and rail running performance

As the project had constraints, we could not change the BG200 frame design, only add to it.
The end result is a carefull compromize between all the performance factors, complexity and cost.

<h3>Rail landing demonstrator</h3>
The goal of this subproject was to demonstrate that a drone can:

* Autonomously navigate to a rail.
* Localize the rail using local vision sensors.
* Plan and execute a smooth track-landing using local vision sensors.

To ease the development, a 500mm size drone was used as a research vehicle.
The tech stack was the following:

* 500mm size drone
* Staaker Autopilot
* Small onboard ARM64 Linux computer
* Intel RealSense stere depth camera for visual input data

The vision, estimation and control stack was fully implemented by me, and consisted of the following C++ pipeline.
The RealSense camera would be configured for minimal latency and filtering.
A custom C++ RANSAC library was developed, and hand tuned for 20Hz performance on a very weak ARM64 linux single board computer.
Using the RANSAC library, I designed a chain of RANSAC filters to isolate the rails from all the other points in the pointcloud with very high robustness, low latency, and 20Hz troughput.
Because the method was purely based on the geometry of the rails, it was extremely robust to common issues with vision systems. It would easily handle any visual changes like lighting conditions, varying degrees of rust, leaves on the track etc. Since it was based on RANSAC filtering, the algorithm was also very robust agains noise in the point cloud data, things like shrubs, leaves, straws, signpoles etc. would not confuse the filter.

Using 3D transofrmations the Linux computer would continously produce a stream of 3D-point-pairs, which represented the current position of the rail in the drones body frame.
This stream would then be feed into a custom rail-landing control system. This system would home the drone on the rail, and a control law would lower the drone carefully, while maintaining contol of x,y-position and yaw. The control law was designed to be robust in such a way that if the drone was divering from its planned path, it would ascend untill it's margin for error was large enough to retry.

The control signal from the rail-landing controller would be feed as low level NED-velocity commands to the Staaker Autopilot system.
And the Staaker Autopilot system would execute these using its control system to safely land.
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

* GPS: 5-10Hz, not hard-real-time timing
* Barometer/compass: ~20Hz sampling
* Accelerometer/gyroscope: 500Hz sampling

At each update of the kalman filter, the readyness of new sensor data is checked for each sensor.

* If GPS data is available, the most expensive and full update step is run, 5.
* Else if magnetometer data is available, update 3. is run
* If barometer data is available, update 4.
* Last, if accelerometer data is available, and it has not yet been "consumed" by any of the other update steps, update 2. is run.

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
<summary><span class="detail-header">High efficiency low-latency live video streaming</span>
To control a drone, an operator depends on a live video stream. I designed and implemented the software stack that does videostreaming in Nordic Unmanneds Staaker drones.</summary>

<h3>General design goals</h3>
Key design goal for the video streaming stack was the following:

* Low end-to-end latency. From the camera grabs a frame untill it is visible on the screen on the ground, there should be no more than 60-70ms for the operator to feel he still has control of the craft.
* Low bandwith. Long range together with maximum power requirements on radio equipment means that the received signal from the drone is weak. This leads to a low maximum bandwidth. We optimized or systems to carry 2 video streams within 1.5megabit of bandwith.
* High tolerance to network packet loss
* High tolerance to network packet jitter
* High energy/compute efficiency

<h3>Implementation</h3>
To get low end-to-end latency, there can be very few buffers in the pipeline.
The only places where data is buffered in the solution is inside the video encoder, which requires at least 1 single frame delay to be able to do delta encoding, and withing the reciving jitterbufer, that handles network packet reordering. Another critical part of the latency was to use hardware accelerated encoding and tune the encoder for minimal latency.

To get the required energy/compute efficiency using VA-API was choosen. This offloads the hard work of H264 video encoding to the underlying graphics hardware.

To handle network packet jitter, a jitterbuffer was used on the receiver side. To handle packet loss, additional forward error correction coding is used on the sender side, and the accompanying FEC-decoding on the reciving side. This lets the link handle X% packet loss, at the cost of X% extra bandwidth, without any loss of information on the receiving side.

The system was implemented in the Rust programming language, using the gstreamer library.
</details>

<details>
<summary><span class="detail-header">Long Range Mesh Radio system</span>
For several of our missions in Nordic Unmanned. Dedicated long range radio links are required. These are used for streaming live data down to the operator as well as controling the drone. I have worked with the selection, testing and verification of the radio system we used.</summary>

<h3>Specification</h3>

<h3>Testing and verification</h3>
</details>

<!--details>
<summary><span class="detail-header">Nordic Unmanned RailRover</span>
todo
</details-->