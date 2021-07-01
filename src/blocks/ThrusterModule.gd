extends BuildModule

export var engine_force:float = 3.0

func _ready():
	pass

func _physics_process(delta):
	block_force_direction = global_transform.basis.y.normalized()
	#sends the force vector to be applied
	#on the main body
	if Input.is_action_pressed("ui_accel"):
		var torque_vec = -transform.origin.normalized().cross(-transform.basis.y)
		#Using direction_to it works as intended
		emit_signal(
			"block_impulse_add", 
			block_force_direction*engine_force, 
			get_parent().global_transform.origin.direction_to(global_transform.origin))
		$Smoke.emitting = true
		pass
	else:
		$Smoke.emitting = false
	pass
