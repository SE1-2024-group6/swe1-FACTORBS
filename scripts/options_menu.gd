extends Control

@onready var buttonPress = $"buttonPress"



func _ready() -> void:
	var gameVolume = 1
	var sfxVolume = 1
	#ALSO ADD CODE FETCHING VOLUME HERE
	buttonPress.volume_db = -5 - 30*(1-(gameVolume*sfxVolume))
	if gameVolume == 0:
		buttonPress.volume_db = -60

func _on_main_menu_button_pressed() -> void:
	buttonPress.play()
	await await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
