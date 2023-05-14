extends Control

const MAIN_MENU = "uid://bor178du6hymf"
var text = "NULL"
@onready var reason_n = $Reason

func set_reason_text(_text: String):
	text = _text

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	reason_n.set_text(text)

func _on_go_menu_pressed():
	get_tree().change_scene_to_file(MAIN_MENU)
	self.queue_free()
