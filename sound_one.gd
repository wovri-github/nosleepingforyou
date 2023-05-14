extends Node3D
	
func _input(event): 
	if event. is_action_pressed("Meow"):
		$AudioStreamPlayer.play()
	pass # Replace with function body.
