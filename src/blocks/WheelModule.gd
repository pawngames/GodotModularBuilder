extends BuildModule

class_name WheelModule

export var wheel_force:float = 5.0
var wheel_spin:float = 0.0

func _ready():
	pass

func _physics_process(delta):
	#updates wheel direction
	block_force_direction = -global_transform.basis.z*wheel_force
	if Input.is_action_pressed("ui_accel"):
		if $RayCast.is_colliding():
			emit_signal("block_impulse_add", block_force_direction, transform.origin)
		wheel_spin += 0.01
	elif Input.is_action_pressed("ui_brake"):
		if $RayCast.is_colliding():
			emit_signal("block_impulse_add", -block_force_direction, transform.origin)
		wheel_spin -= 0.01
	else:
		wheel_spin = lerp_angle(wheel_spin, 0.0, 0.1)
	$Model.rotation += Vector3.UP*wheel_spin
	pass
