extends Node3D
class_name Place

@export var time_consumption_min = 3
@export var time_consumption_max = 6
var is_occupied = false
var victim : CharacterBody3D = null

func victim_reached(body):
	is_occupied = true
	$Timer.paused = false
	$Timer.stop()
	randomize()
	var time_consumption = randi_range(\
			time_consumption_min, time_consumption_max)
	$Timer.start(time_consumption)
	victim = body

func _on_timer_timeout():
	is_occupied = false
	$Timer.stop()
	victim.move_on()
	victim = null
	add_to_group("Unoccupied_places")
	
