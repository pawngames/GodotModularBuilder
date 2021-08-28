# GodotModularBuilder
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Y5fGko-2Xhw/0.jpg)](https://www.youtube.com/watch?v=Y5fGko-2Xhw)

<p>Godot modular physics object builder

What this project got so far:
- A Physics Object node structure
- Module mechanic that allow adding and removing blocks and visual indication of positioning (still buggy, working but lacks a global positioning reference for block adding).
- Each block implementation can add forces to the main Body. Maintained Godot's Vehicle physics implementation for convenience.
- Mouse orbiting camera, click left and drag to orbit and scroll to zoom.
- So far, this blocks are implemented:
 - Base module (indicates overall body orientation)
 - Armor Block - Structural body
 - Armor Slope Block - Same as previous block but sloped
 - Gyro Block - Applies torque to the main body
 - Thruster Block - Applies force to the main body
 - Wheel Body - Godot's wheel body
 - Wheel Steer Block - Same as Wheel body but with steering

Future prospects:
 - Iron out some block adding bugs (indicator goes nuts sometimes)
 - Controller needs a global direction control, my strongest reference here is Space Engineers.
 - Better camera gimbal follow control, for driving.
