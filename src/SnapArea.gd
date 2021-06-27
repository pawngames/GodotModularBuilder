extends Area

class_name SnapArea

signal indicator_pressed(pos, normal, orientation, left)

var target_rot = Vector3.ZERO

func _ready():
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
	$Indicator.rotation.x = lerp_angle($Indicator.rotation.x, target_rot.x, .4)
	$Indicator.rotation.y = lerp_angle($Indicator.rotation.y, target_rot.y, .4)
	pass

func _on_IndicatorArea_mouse_entered():
	$Indicator.visible = true
	pass

func _on_IndicatorArea_mouse_exited():
	$Indicator.visible = false
	pass

func _on_IndicatorArea_input_event(camera, event, click_position:Vector3, click_normal:Vector3, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MASK_RIGHT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_position, 
				click_normal, 
				$Indicator.rotation, 
				false)
		if event.button_index == BUTTON_MASK_LEFT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_normal + global_transform.origin, 
				click_normal, 
				$Indicator.rotation, 
				true)
	if event is InputEventMouseMotion:
		$Indicator.global_transform.origin = click_normal*2 + global_transform.origin
	pass
