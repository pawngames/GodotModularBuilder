# GodotModularBuilder
Godot modular physics object builder

What this project got so far:
- A Physics Object node structure
- Module mechanic that allow adding blocks and visual indication of positioning (still buggy, since i couldn't make snapping working), I think this part as a concept can be worked with but i made something wrong and it seems to be adding blocks only to the first module. I already prepared a signal for block deletion but did not implement it
- Module input sends signals that affect main body (accounting for node position, but it has to be tested), the only force applied right now is up, but i think this here is the main player on the movement/vehicle physics objective. It would be the main abstraction for all blocks.
- Mouse orbiting camera, click left and drag to orbit and scroll to zoom
