extends CollisionShape

tool
class_name BuildModule, "res://assets/module_icon.svg"

func _get_configuration_warning():
	if $Model == null or !($Model is MeshInstance):
		return "A Model node of type MeshInstance is required"
	if $SnapArea == null or !($SnapArea is SnapArea):
		return "A SnapArea node of type SnapArea is required"
	return ""

signal block_torque_add(direction, pos)
signal block_impulse_add(direction, pos)
signal block_add(pos, normal, orientation)
signal block_remove(id)

#indicates this block's force direction, if any
var block_force_direction:Vector3 = Vector3.ZERO
export var block_mass:float = 1.0
export var block_health:float = 100.0
export var block_name:String = "BaseBlock"

func _ready():
	pass

func _physics_process(delta):
	#Each module should implement its own logic
	pass

func _on_SnapArea_indicator_pressed(pos, normal, orientation, left):
	if left:
		emit_signal("block_add", pos, normal, orientation)
	else:
		emit_signal("block_remove", self)
	pass

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func align_with_z(xform, new_z):
	xform.basis.z = -new_z
	xform.basis.x = -xform.basis.y.cross(new_z)
	xform.basis = xform.basis.orthonormalized()
	return xform
