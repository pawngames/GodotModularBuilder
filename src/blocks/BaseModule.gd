extends BuildModule


func _ready():
	pass

func _on_SnapArea_indicator_pressed(pos, normal, orientation, left):
	if left:
		emit_signal("block_add", pos, normal, orientation)
	pass
