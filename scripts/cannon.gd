extends Area2D

@onready var pause_menu = $"../CanvasLayer/PauseMenu"
@onready var sprite = $"Sprite2D"
var paused = false

# Start with pause menu hidden
func _ready() -> void:
	pause_menu.hide()

# If we need to use delta, take out the underscore to signify
func _physics_process(_delta) -> void:

	sprite.look_at(get_global_mouse_position()) 

	if Input.is_action_just_pressed("pause"):
		toggle_pause()

# pause
func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		pause_menu.hide()
	else:
		get_tree().paused = true
		pause_menu.show()

	paused = !paused

func restart_level():
	# should always be paused here, but have the if as a railguard
	if get_tree().paused:
		get_tree().paused = false
	get_tree().reload_current_scene()
