extends Control
const game = preload("res://Map.tscn")
@onready var dificulty_slider = %HSlider

func _on_button_pressed():
	get_tree().change_scene_to_packed(game)
	GameManager.set_dificulty(dificulty_slider.get_value())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_button_2_pressed():
	get_tree().quit()

func _ready():
	$AnimatedSprite2D.play("default")
	%Label.set_text(LvlNames.get_lvl_name(%HSlider.get_value() + 1))

func _on_h_slider_value_changed(_value):
	%Label.set_text(LvlNames.get_lvl_name(%HSlider.get_value() + 1))


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
