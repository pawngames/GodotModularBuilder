extends RigidBody

var forces:Dictionary = {}
var torques:Dictionary = {}

var modules:Array = [
	"res://src/blocks/ArmorModule.tscn",
	"res://src/blocks/ThrusterModule.tscn",
	"res://src/blocks/WheelSteerModule.tscn",
	"res://src/blocks/WheelModule.tscn"
]
var selected:String = "res://src/blocks/ArmorModule.tscn"

func _ready():
	$ArmorModule.connect("block_torque_add", self, "_block_input")
	$ArmorModule.connect("block_impulse_add", self, "_block_input")
	$ArmorModule.connect("block_add", self, "_block_added")
	$ArmorModule.connect("block_remove", self, "_block_removed")
	pass

func _process(delta):
	pass

func _physics_process(delta):
	#for f in forces.keys():
	#	apply_central_impulse(forces.get(f))
	#	#print("pos: " + str(f) + "|for: " + str(forces.get(f)))
	#for t in torques.keys():
	#	apply_torque_impulse(torques.get(t))
	#	#print("pos: " + str(t) + "|for: " + str(torques.get(t)))
	#if forces.size() > 0:
	#	print("------------------")
	#forces.clear()
	#torques.clear()
	pass

func _block_removed(id:BuildModule):
	mass -= id.block_mass
	weight = mass*gravity_scale*9.8
	remove_child(id)
	_recalculate_cm()
	pass

func _block_added(pos, normal):
	var new_module_scene = load(selected).duplicate(true)
	var new_module = new_module_scene.instance()
	add_child(new_module)
	new_module.global_transform.origin = pos + normal
	new_module.connect("block_add", self, "_block_added")
	new_module.connect("block_impulse_add", self, "_block_impulse")
	new_module.connect("block_torque_add", self, "_block_torque")
	new_module.connect("block_remove", self, "_block_removed")
	mass += new_module.block_mass
	weight = mass*gravity_scale*9.8
	_recalculate_cm()
	apply_central_impulse(Vector3.UP)
	pass

func _recalculate_cm():
	#assuming equal mass for every block
	var start_pos = global_transform.origin
	var new_cm = Vector3.ZERO
	var count = 0.0
	for child in get_children():
		if child is BuildModule:
			count += child.block_mass
			new_cm += child.transform.origin*child.block_mass
	new_cm /= count
	for child in get_children():
		if child is BuildModule:
			child.transform.origin -= new_cm
	global_transform.origin -= new_cm.rotated(Vector3.UP, PI/2)
	$CM.transform.origin = Vector3.ZERO
	pass

func _block_impulse(direction, pos):
	#forces[pos] = direction
	apply_central_impulse(direction)
	pass

func _block_torque(direction, pos):
	#torques[pos] = direction
	apply_torque_impulse(direction*2)
	pass	

func _unhandled_key_input(event):
	if event is InputEventKey:
		var evt:InputEventKey = event
		if evt.pressed:
			match event.scancode:
				KEY_1:
					selected = modules[0]
				KEY_2:
					selected = modules[1]
				KEY_3:
					selected = modules[2]
				KEY_4:
					selected = modules[3]
