Deliverables from a final project in the Fall 2017 session of Tennessee Tech
course ME 4140 Intro to Robotics. The goals were:
1. Develope an animation of TALUS using the concepts of forward and inverse
   kinematics (discussed both in ME 4140 and ME 3610 Dynamics of Machinery).
2. Further the development of TALUS hardware systems

This folder contains:
- stlread.m: a function which reads STLs into a MATLAB script
- TALUS_Forward_12_12_17: an unfinished program to complete Goal 1
- TALUS_Forward_12_12_17_demo: the script used to generate the
  following animations.
- Joint_animation: MP4 showing full range of motion for several joints
- Wave_animation: MP4 demonstrating a wave
- TALUS_Dem: an arduino code used to replicate the animate motions on the real robot
- Joint_demo: video of hardware system replicating corresponding animation
- Wave_demo: video of hardware system replicating corresponding animation

Also included are STLs of each rigid body on TALUS made by assembling the
individual part STLs found on the websites. This process required loading them
into Inventor with Mesh Enabler.

This project is by no means complete, as only a portion of the right arm is
functional (F2017). Reccomended future work includes completing forward kinematics for
the full body, verifying inverse kinematics, and working on path planning
concepts.