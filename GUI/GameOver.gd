extends Control

const MAIN_MENU = "uid://bor178du6hymf"
const game = preload("res://Map.tscn")
const game_lvl_increase = 0.2
var text = "NULL"
@onready var reason_n = $Reason


func setup(reason: int, lvl, wins):
	if reason == Over.WIN:
		$Label.hide()
		$PlayAgain.show()
	else:
		$Label.show()
		$PlayAgain.hide()
	$Lvl/Num.set_text(str(lvl))
	$Wins/Num.set_text(str(wins))
	$PlayAgain/NextLvl/Num.set_text(str(lvl + game_lvl_increase))
	
	pass

func set_reason_text(_text: String):
	text = _text

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	reason_n.set_text(text)

func _on_go_menu_pressed():
	get_tree().change_scene_to_file(MAIN_MENU)
	self.hide()


func _on_play_again_pressed():
	get_tree().change_scene_to_packed(game)
	GameManager.set_dificulty(game_lvl_increase)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	self.hide()
