extends Control

@onready var buttonPress = $"buttonPress"

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
