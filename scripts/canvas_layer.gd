extends CanvasLayer

@onready var game = $"../Cannon"

func _on_button_pressed() -> void:
	game.toggle_pause()
