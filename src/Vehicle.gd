extends VehicleBody

var forces:Dictionary = {}
var torques:Dictionary = {}

var modules:Array = [
	["res://src/blocks/ArmorModule.tscn", "res://assets/3d/blocks/armor_block.tres"],
	["res://src/blocks/ThrusterModule.tscn", "res://assets/3d/blocks/thruster_module.tres"],
	["res://src/blocks/WheelSteerModule.tscn", "res://assets/3d/blocks/wheel_module.tres"],
	["res://src/blocks/WheelModule.tscn", "res://assets/3d/blocks/wheel_module.tres"],
	["res://src/blocks/GyroModule.tscn", "res://assets/3d/blocks/gyro_module.tres"],
	["res://src/blocks/CameraModule.tscn", "res://assets/3d/blocks/camera_module.tres"],
]

var selected:Array = modules[0]

var orientation:Vector3 = Vector3.ZERO

func _ready():
	$BaseModule.connect("block_torque_add", self, "_block_input")
	$BaseModule.connect("block_impulse_add", self, "_block_input")
	$BaseModule.connect("block_add", self, "_block_added")
	$BaseModule.connect("block_remove", self, "_block_removed")
	pass

func _process(delta):
	pass

#Some kind of stability control should go here
#Ship gets all kinds of unstable, specially on flight
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

func _block_removed(id):
	mass -= id.block_mass
	weight = mass*gravity_scale*9.8
	remove_child(id)
	#_recalculate_cm()
	apply_central_impulse(Vector3.UP*mass)
	pass

func _block_added(pos:Vector3, normal:Vector3, orientation:Vector3):
	var new_module_scene = load(selected[0]).duplicate(true)
	var new_module = new_module_scene.instance()
	new_module.translate_object_local(to_local(pos + normal))
	add_child(new_module)
	new_module.connect("block_add", self, "_block_added")
	new_module.connect("block_impulse_add", self, "_block_impulse")
	new_module.connect("block_torque_add", self, "_block_torque")
	new_module.connect("block_remove", self, "_block_removed")
	new_module.rotation = orientation
	mass += new_module.block_mass
	weight = mass*gravity_scale*9.8
	#_recalculate_cm()
	apply_central_impulse(Vector3.UP*mass)
	pass

#Since we can't change the center of mass.
#We relocate all blocks instead
func _recalculate_cm():
	#assuming equal mass for every block
	var start_pos = global_transform.origin
	var new_cm:Vector3 = Vector3.ZERO
	var count = 0.0
	for child in get_children():
		if child is BuildModule or child is WheelModule:
			count += child.block_mass
			new_cm += child.transform.origin*child.block_mass
	new_cm /= count
	#new_cm = new_cm.snapped(Vector3.ONE/2)
	print("CM: " + str(new_cm))
	global_transform.origin = to_global(new_cm)
	#Wheel modules are stubborn, they
	#Never change positions correctly
	for child in get_children():
		if child is BuildModule or child is WheelModule:
			child.translate_object_local(-new_cm)
		if child is WheelModule:
			child.translate(-new_cm)
	$CM.transform.origin = Vector3.ZERO
	pass

func _block_impulse(direction:Vector3, pos:Vector3):
	#apply_central_impulse(direction)
	apply_impulse(pos, direction)
	print("-----------------------------")
	print(str(pos) + "|" + str(direction))
	pass

func _block_torque(direction:Vector3, pos:Vector3):
	apply_torque_impulse(direction)
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
				KEY_5:
					selected = modules[4]
				KEY_6:
					selected = modules[5]
