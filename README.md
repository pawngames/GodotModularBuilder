# GodotModularBuilder
Godot modular physics object builder

Godot modular physics object builder

What this project got so far:
- A Physics Object node structure
- Module mechanic that allow adding and removing blocks and visual indication of positioning (still buggy, working but lacks a global positioning reference for block adding).
- Each block implementation can add forces to the main Body. Maintained Godot's Vehicle physics implementation for convenience.
- Mouse orbiting camera, click left and drag to orbit and scroll to zoom.
- So far, this blocks are implemented:
 - Base module (indicates overall body orientation)
 - Armor Block - Structural body
 - Gyro Block - Applies torque to the main body
 - Thruster Block - Applies force to the main body
 - Wheel Body - Godot's wheel body
 - Wheel Steer Block - Same as Wheel body but with steering

Future prospects:
 - Iron out some block adding bugs (indicator goes nuts sometimes)
 - So for only adds center impulse, which is not ideal for more realistic physics. For some reason (probably my fault), when adding positioned impulse, body goes to a fixed direction.
 - Controller needs a global direction control, my strongest reference here is Space Engineers.
 - Better camera gimbal follow control, for driving.
