---
title: 'Nordic Unmanned RailRobot project phase 2: RailRover'
---

<video class="video-width" autoplay="true" muted="true" loop="true" controls="true">
<source src="/files/videos/rail-rover-hello-goodbye.webm" type="video/webm">
<source src="/files/videos/rail-rover-hello-goodbye.mp4" type="video/mp4">
</video>
After the demonstration of [autonomous landing on rails](/pages/autonomous-rail-landing.html), and creating a drone frame that could both drive on rail and fly, the next phase of the RailRobot project was decided to be about demonstrating a useful data capture platform.

For this part of the project, the RailRover was created. Because the focus was on demonstrating a useful data capture platform, it cannot fly but has all the sensors and connectivity of the RailRobot.

My team has worked on developing the software in the RailRover over the course of 1 year.
This is the first time we have designed an internet-connected vehicle, and designing and 
implementing this huge change took the better part of the year.
Features we implemented include:

- Integration with existing ground control software, letting the operator do waypoint missions, automatic navigation, program cameras, gimbals, etc.
- Internet-connected RailRover, controllable from anywhere on the planet with an internet connection.
- Secure network
- IP-based network + standard Linux computer inside. Allows very easy integration of arbitrary sensors, like LIDARS, inspection cameras, gimbals, etc.
- Live video streaming of all 3 on-board cameras. With our custom low latency, low bandwidth, and high-efficiency video-encoding stack.
- Ability to record high-definition videos while streaming low bandwidth streams to the operator.
- Ability to download captured high-definition inspection data
- Management GUI, usable by non-engineers, for seeing system status, logs, restarting system services, configuring parameters, etc.