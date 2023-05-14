extends Node

const GAMEOVER = preload("res://GUI/GameOver.tscn")
var wins = 0
var result = 0
var lvl = 1
var victim_speed = 1
var sleep_devider = 1


func set_dificulty(value):
	lvl += value
	victim_speed += value
	sleep_devider += value * 0.5

func end_game(reason: int, text: String):
	var gameover_n = GAMEOVER.instantiate()
	if reason == Over.WIN:
		wins += 1
		result = wins
	else:
		result = wins
		wins = 0
	gameover_n.show()
	gameover_n.setup(reason, lvl, wins)
	gameover_n.set_reason_text(text)
	add_child(gameover_n)
	get_tree().paused = true
