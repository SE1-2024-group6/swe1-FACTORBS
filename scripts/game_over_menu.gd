extends Control

@onready var game = $"../../Cannon"
@onready var menu = get_parent()
@onready var cr = $ColorRect

signal buttonPress()


func _on_main_menu_pressed() -> void:
	buttonPress.emit()
	await get_tree().create_timer(0.2).timeout
	game.toggle_pause()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	menu.hide()


func _on_restart_pressed() -> void:
	buttonPress.emit()
	await get_tree().create_timer(0.2).timeout
	game.restart_level()
	menu.hide()
