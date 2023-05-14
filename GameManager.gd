extends Node

var victim_speed = 1
var sleep_devider = 1

func set_dificulty(value):
	victim_speed += value
	sleep_devider += value *0.5
