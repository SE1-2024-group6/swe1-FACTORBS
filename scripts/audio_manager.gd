extends Node2D

@onready var FireCannon = $"FireCannon"
@onready var buttonPress = $"buttonPress"
@onready var gameOver = $"gameOver"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gameVolume = 1
	var sfxVolume = 1
	# PUT CODE FETCHING VOLUME HERE!!!
	for i in get_children():
		i.volume_db = -5 - 30*(1-(gameVolume*sfxVolume))
		if gameVolume == 0:
			i.volume_db = -60
	$"wrongBuzz".volume_db += 10
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
