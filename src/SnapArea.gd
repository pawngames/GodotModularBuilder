extends Area

class_name SnapArea

signal indicator_pressed(pos, normal, orientation, left)

var target_rot = Vector3.ZERO

func _ready():
	_change_model()
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_page_up"):
		target_rot.x += PI/2
	if Input.is_action_just_pressed("ui_page_down"):
		target_rot.x -= PI/2
	if Input.is_action_just_pressed("ui_home"):
		target_rot.y += PI/2
	if Input.is_action_just_pressed("ui_end"):
		target_rot.y -= PI/2
	
	target_rot = normalize_angle_vec(target_rot)
	
	var a = Quat($Indicator.transform.basis)
	var b = Quat(target_rot)
	# Interpolate using spherical-linear interpolation (SLERP).
	var c = a.slerp(b,0.5) # find halfway point between a and b
	# Apply back
	$Indicator.transform.basis = Basis(c)
	
	#$Indicator.rotation.x = lerp_angle($Indicator.rotation.x, target_rot.x, .6)
	#$Indicator.rotation.y = lerp_angle($Indicator.rotation.y, target_rot.y, .6)
	pass

func _unhandled_key_input(event):
	_change_model()
	pass

func _change_model():
	var model = load(get_parent().get_parent().selected[1]).duplicate(true)
	var mat = $Indicator/IndicatorShape.get_surface_material(0)
	$Indicator/IndicatorShape.mesh = model
	for surface in range($Indicator/IndicatorShape.mesh.get_surface_count()):
		$Indicator/IndicatorShape.mesh.surface_set_material(surface, mat)
	pass

func normalize_angle_vec(vec:Vector3)->Vector3:
	vec.x = normalize_angle(vec.x)
	vec.y = normalize_angle(vec.y)
	vec.z = normalize_angle(vec.z)
	return vec

#avoid large angles transition
func normalize_angle(angle:float)->float:
	angle =  fmod(angle,2*PI)
	angle = fmod((angle + 2*PI), 2*PI)
	if angle > PI:
		angle -= 2*PI
	return angle

func _on_IndicatorArea_mouse_entered():
	$Indicator.visible = true
	pass

func _on_IndicatorArea_mouse_exited():
	$Indicator.visible = false
	pass

func _on_IndicatorArea_input_event(camera, event, click_position:Vector3, click_normal:Vector3, shape_idx):
	if event is InputEventMouseButton:
		#Ajustar
		var rot:Vector3 = get_parent().rotation + $Indicator.rotation
		if event.button_index == BUTTON_MASK_RIGHT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_position, 
				click_normal, 
				rot.snapped(Vector3.ONE*PI/2), 
				false)
		if event.button_index == BUTTON_MASK_LEFT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_normal + global_transform.origin, 
				click_normal, 
				rot.snapped(Vector3.ONE*PI/2), 
				true)
	if event is InputEventMouseMotion:
		$Indicator.global_transform.origin = click_normal*2 + global_transform.origin
	pass
