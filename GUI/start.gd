extends Control

var screen_2 = load("res://assets/Screens/screen-2.png")
var frame = 0

func _ready():
	$a.play()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		frame += 1
		if frame == 1:
			$TextureRect.texture = screen_2
		elif frame > 1:
			get_tree().change_scene_to_file("uid://bor178du6hymf")


func _on_1_finished():
	$b.play()


func _on_2_finished():
	$c.play()


func _on_3_finished():
	$TextureRect.texture = screen_2
