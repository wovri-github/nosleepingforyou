extends Node

var GAME_OVER = preload("res://GUI/GameOver.tscn")
var victim_speed = 1
var sleep_devider = 1

func set_dificulty(value):
	victim_speed += value
	sleep_devider += value *0.5

func end_game(reason: int, text: String):
	var game_over_inst = GAME_OVER.instantiate()
	game_over_inst.set_reason_text(text)
	add_child(game_over_inst)
	get_tree().paused = true
