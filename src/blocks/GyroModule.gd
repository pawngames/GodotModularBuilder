extends BuildModule

export var gyro_force:float = 2.0

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		emit_signal("block_torque_add", global_transform.basis.x*gyro_force, transform.origin)
	if Input.is_action_pressed("ui_down"):
		emit_signal("block_torque_add", -global_transform.basis.x*gyro_force, transform.origin)
	if Input.is_action_pressed("ui_left"):
		emit_signal("block_torque_add", global_transform.basis.z*gyro_force, transform.origin)
	if Input.is_action_pressed("ui_right"):
		emit_signal("block_torque_add", -global_transform.basis.z*gyro_force, transform.origin)
	if Input.is_action_pressed("ui_prev"):
		emit_signal("block_torque_add", global_transform.basis.y*gyro_force, transform.origin)
	if Input.is_action_pressed("ui_next"):
		emit_signal("block_torque_add", -global_transform.basis.y*gyro_force, transform.origin)
	pass
