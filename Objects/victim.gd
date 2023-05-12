extends CharacterBody3D

const WAKING_TIME = 5
const SPEED = 5.0
var rng = RandomNumberGenerator.new()
@onready var nav_agent := $NavigationAgent3D



func wake_up():
	$Timer.start(WAKING_TIME)

func _on_timer_timeout():
	var beds = get_tree().get_nodes_in_group("Unoccupied_beds")

	var target_bed = beds[rng.randi() % beds.size()]
	set_target_location(target_bed.position)
	#position = target_bed.position + Vector3(0.4,0,0)



func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()

func set_target_location(target_location):
	nav_agent.set_target_position(target_location)
