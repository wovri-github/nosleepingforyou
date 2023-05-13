extends Control
const game = preload("res://test.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_packed(game)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_button_2_pressed():
	get_tree().quit()
