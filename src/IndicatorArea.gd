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
			emit_signal("indicator_pressed", $Indicator.global_transform.origin, click_normal, true)
	if event is InputEventMouseMotion:
		$Indicator.global_transform.basis = align_with_y($Indicator.global_transform.basis, click_normal)
		$Indicator.global_transform.origin = click_position.snapped(Vector3.ONE) + transform.origin
		print($Indicator.global_transform.origin)
	pass

func align_with_y(basis, new_y):
	basis.y = new_y
	basis.x = -basis.z.cross(new_y)
	basis = basis.orthonormalized()
	return basis
