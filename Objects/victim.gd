extends Area3D

const WAKING_TIME = 5

var rng = RandomNumberGenerator.new()

func wake_up():
	$Timer.start(WAKING_TIME)


func _on_timer_timeout():
	var beds = get_tree().get_nodes_in_group("Unoccupied_beds")

	var target_bed = beds[rng.randi() % beds.size()]
	
	position = target_bed.position + Vector3(0.4,0,0)
