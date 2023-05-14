extends StaticBody3D
class_name Bed

const sleep_bar_tscn = preload("res://sleep_bar.tscn")
var sleep_needed = 30.0 / (GameManager.sleep_devider)
var someone_sleeping = false
var victim : CharacterBody3D = null

signal sleep_timer(time_left)
signal sleeping_vicim_name(text)

func change_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.RED
	
func reset_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.AQUA

func victim_sleep(body):
	someone_sleeping = true
	$Timer.paused = false
	$Timer.stop()
	sleep_timer.emit(100)
	$Timer.start(sleep_needed)
	sleeping_vicim_name.emit(body.name)
	victim = body

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		change_color()
		if someone_sleeping:
			$Timer.paused = true
			sleep_timer.emit(100)
			victim.position.z -= 1
			someone_sleeping = false
			sleep_timer.emit(0)
			$Timer.paused = true
			sleeping_vicim_name.emit("")
			victim.wake_up()
			victim = null

func _on_area_3d_body_exited(body):
	if get_tree().paused:
		return
	if body.is_in_group("Player"):
		reset_color()
		if someone_sleeping:
			$Timer.paused = false
			$Timer.stop()
			$Timer.start(sleep_needed)

func _ready():
	$MeshInstance3D.mesh.material = $MeshInstance3D.mesh.material.duplicate()
	reset_color()
	
	var bar = sleep_bar_tscn.instantiate()
	get_tree().root.get_node("Main/Bars").add_child(bar)
	sleep_timer.connect(bar.set_bar_value)
	sleeping_vicim_name.connect(bar.set_victim_name)

func _process(_delta):
	if !$Timer.paused and someone_sleeping:
		sleep_timer.emit(100*$Timer.time_left/sleep_needed)

func _on_timer_timeout():
	GameManager.end_game(Over.TIME_OUT, str(victim.name + " wypoczął!"))
	




