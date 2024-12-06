extends Control

@onready var game = $"../../Cannon"
@onready var menu = get_parent()
@onready var cr = $ColorRect

func _on_main_menu_pressed() -> void:
	game.toggle_pause()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	menu.hide()


func _on_restart_pressed() -> void:
	game.restart_level()
	menu.hide()
