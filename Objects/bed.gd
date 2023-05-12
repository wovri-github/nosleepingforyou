extends StaticBody3D

const sleep_bar_tscn = preload("res://sleep_bar.tscn")
const SLEEP_NEEDED = 30
var someone_sleeping = false
var victim : CharacterBody3D = null

signal sleep_timer(time_left)
signal sleeping_vicim_name(text)

func change_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.RED
	
func reset_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.AQUA


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		change_color()
		if someone_sleeping:
			$Timer.paused = true
			sleep_timer.emit(100)
			victim.position.z -= 2
	if body.is_in_group("Victims"):
		someone_sleeping = true
		$Timer.paused = false
		sleep_timer.emit(100)
		$Timer.start(SLEEP_NEEDED)
		sleeping_vicim_name.emit(body.name)
		victim = body
		

func _on_area_3d_body_exited(body):
	if get_tree().paused:
		return
	if body.is_in_group("Player"):
		reset_color()
		if someone_sleeping:
			$Timer.paused = false
			$Timer.start(SLEEP_NEEDED)
	if body.is_in_group("Victims"):
		someone_sleeping = false
		sleep_timer.emit(0)
		$Timer.paused = true
		sleeping_vicim_name.emit("")
		victim = null
		body.wake_up()
		add_to_group("Unoccupied_beds")

func _ready():
	$MeshInstance3D.mesh.material = $MeshInstance3D.mesh.material.duplicate()
	reset_color()
	
	var bar = sleep_bar_tscn.instantiate()
	get_tree().root.get_node("Main/Bars").add_child(bar)
	sleep_timer.connect(bar.set_bar_value)
	sleeping_vicim_name.connect(bar.set_victim_name)

func _process(delta):
	if !$Timer.paused and someone_sleeping:
		sleep_timer.emit(100*$Timer.time_left/SLEEP_NEEDED)

func _on_timer_timeout():
	add_child(preload("res://GUI/GameOver.tscn").instantiate())
	get_tree().paused = true
	




