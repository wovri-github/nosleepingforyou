extends CharacterBody3D

const SPEED = 1.8
const BED_CHANCE = 0.5
var sleeping = false
var target_place
var bed: Bed = null
var rng = RandomNumberGenerator.new()
@onready var nav_agent := $NavigationAgent3D

func _ready():
	rng.randomize()
	$Guy/AnimationPlayer.queue("Idle")
	move_on()


func wake_up():
	$Guy/AnimationPlayer.stop()
	$Guy/AnimationPlayer.clear_queue()
	$Guy/AnimationPlayer.play_backwards("waking_up")

func move_on():
	randomize()
	sleeping = false
	if randf() <= BED_CHANCE:
		var beds = get_tree().get_nodes_in_group("Unoccupied_beds")
		var target_bed = beds[rng.randi() % beds.size()]
		bed = target_bed
		target_place = target_bed
		target_bed.remove_from_group("Unoccupied_beds")
		set_target_location(target_bed.get_node("SitPosition").global_transform.origin)
	else:
		var places = get_tree().get_nodes_in_group("Unoccupied_places")
		target_place = places[rng.randi() % places.size()]
		target_place.remove_from_group("Unoccupied_places")
		set_target_location(target_place.position)
	$Guy/AnimationPlayer.stop()
	$Guy/AnimationPlayer.clear_queue()
	$Guy/AnimationPlayer.queue("walk")



func _physics_process(_delta):
	
	if $Guy/AnimationPlayer.current_animation == "layDown":
		position = bed.get_node("LayDownPosition").global_transform.origin
	if $Guy/AnimationPlayer.current_animation == "sleep":
		position = bed.get_node("SleepPosition").global_transform.origin
		
	if $Guy/AnimationPlayer.current_animation == "waking_up":
		position = bed.get_node("LayDownPosition").global_transform.origin
	if $Guy/AnimationPlayer.current_animation == "sitToStand":
		position = bed.get_node("SitPosition").global_transform.origin
		
	if !nav_agent.is_target_reached():
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		new_velocity.y = 0
		velocity = new_velocity
		rotation.y = lerp_angle(rotation.y, Vector2(velocity.z, velocity.x).angle(), 0.1)
		move_and_slide()
		

func set_target_location(target_location):
	nav_agent.set_target_position(target_location)



func _on_animation_player_animation_changed(old_name, new_name):
	if old_name == "standToSit" and new_name == "layDown":
		#position = bed.get_node("LayDownPosition").global_transform.origin
		pass
	if old_name == "layDown" and new_name == "sleep":
		bed.victim_sleep(self)
		#position = bed.get_node("SleepPosition").global_transform.origin


func _on_navigation_agent_3d_target_reached():
	if target_place is Bed:
		sleeping = true
		$Guy/AnimationPlayer.stop()
		$Guy/AnimationPlayer.clear_queue()
		position = bed.get_node("SitPosition").global_transform.origin
		#position = nav_agent.target_position + Vector3(-0.65,0,0)
		#position.y = 0.1
		$Guy/AnimationPlayer.queue("standToSit")
		$Guy/AnimationPlayer.queue("layDown")
		$Guy/AnimationPlayer.queue("sleep")
		rotation.y = bed.rotation.y - PI / 2
	elif target_place is Place:
		assert(!target_place.is_occupied, "This bed shouldnt be occupied")
		$Guy/AnimationPlayer.stop()
		$Guy/AnimationPlayer.clear_queue()
		$Guy/AnimationPlayer.queue("Idle")
		target_place.victim_reached(self)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "waking_up":
		$Guy/AnimationPlayer.play_backwards("sitToStand")
	if anim_name == "sitToStand":
		target_place.add_to_group("Unoccupied_beds")
		#position = bed.get_node("SitPosition").global_transform.origin
		position.y = 0
		move_on()
