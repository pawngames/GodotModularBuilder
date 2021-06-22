extends RigidBody

var forces:Array = []

func _ready():
	$BuildModule.connect("block_input_pressed", self, "_block_input")
	$BuildModule.connect("block_add", self, "_block_added")
	$BuildModule.connect("block_remove", self, "_block_removed")
	pass

func _process(delta):
	var force:Vector3 = Vector3.ZERO
	for f in forces:
		apply_impulse(f[1], f[0])
	forces.clear()
	pass

func _block_removed(id):
	remove_child(id)
	mass -= 1.0
	weight = mass*gravity_scale*9.8
	_recalculate_cm()
	pass

func _block_added(pos, normal):
	var new_module_scene = load("res://src/BuildModule.tscn").duplicate(true)
	var new_module = new_module_scene.instance()
	add_child(new_module)
	new_module.global_transform.origin = pos + normal
	new_module.connect("block_add", self, "_block_added")
	new_module.connect("block_input_pressed", self, "_block_input")
	new_module.connect("block_remove", self, "_block_removed")
	mass += 1.0
	weight = mass*gravity_scale*9.8
	_recalculate_cm()
	pass

func _recalculate_cm():
	#assuming equal mass for every block
	var start_pos = global_transform.origin
	var new_cm = Vector3.ZERO
	var count = 0
	for child in get_children():
		if child is CollisionShape:
			count += 1
			new_cm += child.transform.origin
	new_cm /= count
	print("ncm" + str(new_cm))
	for child in get_children():
		if child is CollisionShape:
			child.transform.origin -= new_cm/2
	global_transform.origin -= new_cm.rotated(Vector3.UP, PI/2)/2
	print("gt" + str(global_transform.origin))
	$CM.transform.origin = Vector3.ZERO
	pass

func _block_input(direction, pos):
	forces.append([direction, pos])
	pass
