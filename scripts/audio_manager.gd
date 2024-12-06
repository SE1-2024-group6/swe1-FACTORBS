extends Node2D

@onready var FireCannon = $"FireCannon"
@onready var buttonPress = $"buttonPress"
@onready var gameOver = $"gameOver"
@onready var musicPlayer = $"musicPlayer"
@onready var musicTimer = $"musicPlayer/Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gameVolume = 1
	var sfxVolume = 1
	var musicVolume = 1
	# PUT CODE FETCHING VOLUME HERE!!!
	for i in get_children():
		i.volume_db = -5 - 30*(1-(gameVolume*sfxVolume))
		if gameVolume == 0 or sfxVolume == 0:
			i.volume_db = -60
	$"wrongBuzz".volume_db += 10
	musicPlayer.volume_db = 0 - 30*(1-(gameVolume*musicVolume))
	if gameVolume == 0 or musicVolume == 0:
		musicPlayer.volume_db = 0
	musicPlayer.play()
	musicTimer.start()


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


func _on_timer_timeout() -> void:
	musicPlayer.play()
	musicTimer.start()
