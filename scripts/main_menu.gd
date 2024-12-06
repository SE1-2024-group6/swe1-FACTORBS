extends Control

@onready var buttonPress = $"buttonPress"



func _ready() -> void:
	var gameVolume = 1
	var sfxVolume = 1
	#ALSO ADD CODE FETCHING VOLUME HERE
	buttonPress.volume_db = -5 - 30*(1-(gameVolume*sfxVolume))
	if gameVolume == 0:
		buttonPress.volume_db = -60

func _on_quit_button_pressed() -> void:
	buttonPress.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()

func _on_start_button_pressed() -> void:
	buttonPress.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_options_button_pressed() -> void:
	buttonPress.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/OptionsMenu.tscn")
