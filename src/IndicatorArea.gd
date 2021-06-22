extends Area

signal indicator_pressed(pos, normal, left)

func _ready():
	pass

func _process(delta):
	pass

func _on_IndicatorArea_mouse_entered():
	$Indicator.visible = true
	pass

func _on_IndicatorArea_mouse_exited():
	$Indicator.visible = false
	pass

func _on_IndicatorArea_input_event(camera, event, click_position:Vector3, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MASK_RIGHT and event.pressed:
			print("clicked_r")
			emit_signal("indicator_pressed", click_position, click_normal, false)
		if event.button_index == BUTTON_MASK_LEFT and event.pressed:
			print("clicked_l")
			emit_signal("indicator_pressed", click_normal + global_transform.origin, click_normal, true)
	if event is InputEventMouseMotion:
		$Indicator.global_transform.origin = click_normal*2 + global_transform.origin
	pass
