extends RigidBody

var forces:Array = []

func _ready():
	$Module.connect("block_input_pressed", self, "_block_input")
	$Module.connect("block_add", self, "_block_added")
	pass

func _process(delta):
	var force:Vector3 = Vector3.ZERO
	for f in forces:
		apply_impulse(f[1], f[0])
	forces.clear()
	pass

func _block_added(pos, normal):
	var new_module_scene = load("res://src/Module.tscn").duplicate(true)
	var new_module = new_module_scene.instance()
	add_child(new_module)
	new_module.global_transform.origin = pos + normal
	new_module.connect("block_add", self, "_block_added")
	pass

func _block_input(direction, pos):
	forces.append([direction, pos])
	pass
