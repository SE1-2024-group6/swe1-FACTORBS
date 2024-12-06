extends Control

@onready var buttonPress = $"buttonPress"

func _on_main_menu_button_pressed() -> void:
	buttonPress.play()
	await await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
