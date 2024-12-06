extends Node2D

@onready var FireCannon = $"FireCannon"
@onready var buttonPress = $"buttonPress"
@onready var gameOver = $"gameOver"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cannon_fire_cannon() -> void:
	FireCannon.play()


func _on_game_master_game_over() -> void:
	gameOver.play()


func _on_button_pressed() -> void:
	buttonPress.play()


func _on_pause_menu_button_press() -> void:
	buttonPress.play()


func _on_game_over_menu_button_press() -> void:
	buttonPress.play()
