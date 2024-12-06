extends Control

@onready var buttonPress = $"buttonPress"



func _ready() -> void:
	Utils.load_settings()
	$MarginContainer/VBoxContainer/VBoxContainer/master_slider.value = Global.master_volume
	$MarginContainer/VBoxContainer/VBoxContainer/sfx_slider.value = Global.sfx_volume
	$MarginContainer/VBoxContainer/VBoxContainer/music_slider.value = Global.music_volume
	
	buttonPress.volume_db = -5 - 30*(1-(Global.master_volume*Global.sfx_volume))
	if Global.master_volume == 0 or Global.sfx_volume == 0:
		buttonPress.volume_db = -60

func _on_main_menu_button_pressed() -> void:
	buttonPress.play()
	await await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
