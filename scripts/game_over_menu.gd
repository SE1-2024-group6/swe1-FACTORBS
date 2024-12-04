extends Control

@onready var game = $"../../Cannon"
@onready var menu = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	game.toggle_pause()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	menu.hide()


func _on_restart_pressed() -> void:
	game.restart_level()
	menu.hide()
