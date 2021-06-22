extends CollisionShape

class_name BuildModule

signal block_input_pressed(direction, pos)
signal block_add(pos, normal)
signal block_remove(id)

#indicates this block's force direction
var block_direction:Vector3 = global_transform.basis.y

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		#sends the force vector to be applied
		#on the main body
		emit_signal("block_input_pressed", global_transform.basis.y*10.0, transform.origin)
		pass
	pass

func _on_SnapArea_indicator_pressed(pos, normal, left):
	if left:
		emit_signal("block_add", pos, normal)
	else:
		emit_signal("block_remove", self)
	pass
