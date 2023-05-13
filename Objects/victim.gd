extends CharacterBody3D

const WAKING_TIME = 5
const SPEED = 5.0
var sleeping = false
var bed = null
var rng = RandomNumberGenerator.new()
@onready var nav_agent := $NavigationAgent3D

func _ready():
	rng.randomize()
	$Guy/AnimationPlayer.queue("Idle")

func wake_up():
	$Guy/AnimationPlayer.stop()
	$Guy/AnimationPlayer.clear_queue()
	$Guy/AnimationPlayer.queue("Idle")
	$Timer.start(WAKING_TIME)

func _on_timer_timeout():
	var beds = get_tree().get_nodes_in_group("Unoccupied_beds")

	var target_bed = beds[rng.randi() % beds.size()]
	bed = target_bed
	target_bed.remove_from_group("Unoccupied_beds")
	set_target_location(target_bed.position)
	sleeping = false
	$Guy/AnimationPlayer.stop()
	$Guy/AnimationPlayer.clear_queue()
	$Guy/AnimationPlayer.queue("walk")
	#position = target_bed.position + Vector3(0.4,0,0)



func _physics_process(_delta):
	if !sleeping:
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		if nav_agent.distance_to_target() < 1.5:
			sleeping = true
			position = nav_agent.target_position + Vector3(0.4,0,0)
			position.y = 0
			$Guy/AnimationPlayer.stop()
			$Guy/AnimationPlayer.clear_queue()
			$Guy/AnimationPlayer.queue("layDown")
			$Guy/AnimationPlayer.queue("sleep")
			rotation.y = bed.rotation.y - PI / 2
			bed.victim_sleep(self)
		else:
			var new_velocity = (next_location - current_location).normalized() * SPEED
			new_velocity.y = 0
			velocity = new_velocity
			rotation.y = lerp_angle(rotation.y, Vector2(velocity.z, velocity.x).angle(), 0.1)
			move_and_slide()
		

func set_target_location(target_location):
	nav_agent.set_target_position(target_location)
