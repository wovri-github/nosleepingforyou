extends StaticBody3D

func change_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.RED
	
func reset_color():
	$MeshInstance3D.mesh.material.albedo_color = Color.AQUA


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		change_color()


func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		reset_color()
