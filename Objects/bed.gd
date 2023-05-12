extends StaticBody3D

const sleep_bar_tscn = preload("res://sleep_bar.tscn")
const SLEEP_NEEDED = 30
var someone_sleeping = true # true only for testing
signal sleep_timer(time_left)

func change_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.RED
	
func reset_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.AQUA

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		change_color()
		$Timer.paused = true
		sleep_timer.emit(100)

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		reset_color()
		$Timer.paused = false
		$Timer.start(SLEEP_NEEDED)

func _ready():
	$MeshInstance3D.mesh.material = $MeshInstance3D.mesh.material.duplicate()
	reset_color()
	
	var bar = sleep_bar_tscn.instantiate()
	get_tree().root.get_node("Main/Bars").add_child(bar)
	sleep_timer.connect(bar.set_value)
	$Timer.start(SLEEP_NEEDED)

func _process(delta):
	if !$Timer.paused:
#		print(100*$Timer.time_left/SLEEP_NEEDED)
		sleep_timer.emit(100*$Timer.time_left/SLEEP_NEEDED)

func _on_timer_timeout():
	add_child(preload("res://GUI/GameOver.tscn").instantiate())
	

