extends BuildModule

export var engine_force:float = 1.0

func _ready():
	pass

func _physics_process(delta):
	block_force_direction = global_transform.basis.y
	#sends the force vector to be applied
	#on the main body
	if Input.is_action_pressed("ui_accel"):
		emit_signal("block_impulse_add", block_force_direction*engine_force, transform.origin)
		$Smoke.emitting = true
		pass
	elif Input.is_action_pressed("ui_brake"):
		emit_signal("block_impulse_add", -block_force_direction*engine_force, transform.origin)
		$Smoke.emitting = true
		pass
	else:
		$Smoke.emitting = false
	pass
