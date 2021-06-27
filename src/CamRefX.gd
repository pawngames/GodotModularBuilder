extends Spatial

var invert_y = false
var invert_x = false
var mouse_control = false
var mouse_sensitivity = 0.005

var max_zoom = 3.0
var min_zoom = 0.5
var zoom_speed = 0.2

var zoom = min_zoom + (max_zoom - min_zoom)/2

var btn_down:bool = false

func _ready():
	pass

func _process(delta):
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	global_transform.origin = $"../Vehicle".global_transform.origin
	if Input.is_action_pressed("ui_accel"):
		#Camera needs better following behavior,
		rotation.y = lerp_angle(
			rotation.y, 
			$"../Vehicle".rotation.y + PI/2, 
			.2)
		$CamRefY.rotation.z = lerp_angle(
			$CamRefY.rotation.z, PI/8, .2)
			#does nothing, only testing
		$CamRefY/CamRefZ.rotation.x = lerp_angle(
			$CamRefY/CamRefZ.rotation.x, 0.0, .2)
	if Input.is_action_pressed("ui_brake"):
		rotation.y = lerp_angle(rotation.y, $"../Vehicle".rotation.y - PI/2, .2)
		$CamRefY.rotation.z = lerp_angle(
			$CamRefY.rotation.z, $"../Vehicle".rotation.z + PI/8, .2)
		$CamRefY/CamRefZ.rotation.x = lerp_angle(
			$CamRefY/CamRefZ.rotation.x, -abs($"../Vehicle".rotation.x), .2)
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion and btn_down:
		if event.relative.x != 0:
			var dir = 1 if invert_x else -1
			rotate_object_local(Vector3.UP, dir * event.relative.x * mouse_sensitivity)
		if event.relative.y != 0:
			var dir = 1 if invert_y else -1
			$CamRefY.rotate_object_local(Vector3.FORWARD, dir * event.relative.y * mouse_sensitivity)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom -= zoom_speed
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom += zoom_speed
		if event.button_index == BUTTON_MIDDLE and event.pressed:
			btn_down = true
		if event.button_index == BUTTON_MIDDLE and !event.pressed:
			btn_down = false
		zoom = clamp(zoom, min_zoom, max_zoom)
	pass
