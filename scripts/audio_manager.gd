extends Node2D

@onready var FireCannon = $"FireCannon"
@onready var buttonPress = $"buttonPress"
@onready var gameOver = $"gameOver"
@onready var musicPlayer = $"musicPlayer"
@onready var musicTimer = $"musicPlayer/Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_volumes()

	# Start playing music when ready
	musicPlayer.play()
	musicTimer.start()

# Function to update the volumes based on global variables
func _update_volumes() -> void:
	for i in get_children():
		if i is AudioStreamPlayer:
			i.volume_db = -5 - 30 * (1 - (Global.master_volume * Global.sfx_volume))
			if Global.master_volume == 0 or Global.sfx_volume == 0:
				i.volume_db = -60

	musicPlayer.volume_db = -30 * (1 - (Global.master_volume * Global.music_volume))
	if Global.master_volume == 0 or Global.music_volume == 0:
		musicPlayer.volume_db = -60


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
