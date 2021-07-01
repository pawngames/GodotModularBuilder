extends VehicleWheel

class_name WheelModule

signal block_torque_add(direction, pos)
signal block_impulse_add(direction, pos)
signal block_add(pos, normal, orientation)
signal block_remove(id)

export var wheel_increment:float = 1.0
export var wheel_max_force:float = 500.0
var wheel_spin:float = 0.0

export var block_mass:float = 1.0
export var block_health:float = 100.0
export var block_name:String = "BaseBlock"

func _ready():
	pass

func _physics_process(delta):
	#updates wheel direction
	if Input.is_action_pressed("ui_accel"):
		engine_force += 10.0
	elif Input.is_action_pressed("ui_brake"):
		engine_force -= 10.0
	else:
		engine_force = lerp(engine_force, 0.0, 0.1)
	engine_force = clamp(engine_force, -wheel_max_force/3, wheel_max_force)
	print(engine_force)
	pass

func _on_SnapArea_indicator_pressed(pos, normal, orientation, left):
	if left:
		emit_signal("block_add", pos, normal, orientation)
	else:
		emit_signal("block_remove", self)
	pass
