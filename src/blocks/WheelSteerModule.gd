extends WheelModule

var wheel_turn:float = 0.0

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_steer_left"):
		wheel_turn = lerp_angle(wheel_turn, PI/8, .1)
	elif Input.is_action_pressed("ui_steer_right"):
		wheel_turn = lerp_angle(wheel_turn, -PI/8, .1)
	else:
		wheel_turn = lerp_angle(wheel_turn, 0.0, .2)
	steering = wheel_turn
	._physics_process(delta)
	pass
