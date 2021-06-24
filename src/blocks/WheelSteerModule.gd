extends WheelModule

var wheel_turn:float = 0.0

func _ready():
	pass

func _physics_process(delta):
	block_force_direction = global_transform.basis.x.normalized()*wheel_force
	if Input.is_action_pressed("ui_steer_left"):
		wheel_turn = lerp_angle(wheel_turn, PI/6, .01)
	elif Input.is_action_pressed("ui_steer_right"):
		wheel_turn = lerp_angle(wheel_turn, -PI/6, .01)
	else:
		wheel_turn = lerp_angle(wheel_turn, 0.0, .5)
	rotation.y = wheel_turn
	if $RayCast.is_colliding() and Input.is_action_pressed("ui_accel"):
		emit_signal("block_torque_add", block_force_direction*wheel_turn*10.0, transform.origin)
	._physics_process(delta)
	pass
