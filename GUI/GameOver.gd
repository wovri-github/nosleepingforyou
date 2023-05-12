extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_go_menu_pressed():
	get_tree().change_scene_to_file("uid://bor178du6hymf")
