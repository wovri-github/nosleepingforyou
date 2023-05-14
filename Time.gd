extends Label

const NIGHT_TIME = 360
const N_OF_HOURS = 6

func _ready():
	$Timer.start(NIGHT_TIME)

func _process(delta):
	var t = 1 - $Timer.time_left / NIGHT_TIME
	var h = floor(N_OF_HOURS * t)
	var m = int(floor(60 * N_OF_HOURS * t)) % 60
	var txt = ""
	if h < 10:
		txt += "0"
	txt += str(h) + ":"
	if m < 10:
		txt += "0"
	txt += str(m)
	text = txt


func _on_timer_timeout():
	var menu = preload("res://GUI/GameOver.tscn").instantiate()
	get_tree().root.get_node("Main").add_child(menu)
	menu.find_child("Reason").text = "You win!"
	get_tree().paused = true
