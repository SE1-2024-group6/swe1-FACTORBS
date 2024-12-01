extends Area2D

@onready var pause_menu = $"../CanvasLayer/PauseMenu"
@onready var sprite = $"Sprite2D"
@onready var primary_orb = $"PrimaryOrb"
@onready var secondary_orb = $"SecondaryOrb"
var paused = false

# Generate ammo
func GenerateAmmoNumber() -> int:
	return randi_range(1, 9)
	#TODO: implement ammo generation algorithm
	
func SwapAmmo() -> void:
	var temp = primary_orb.GetNumber()
	primary_orb.SetNumber(secondary_orb.GetNumber())
	secondary_orb.SetNumber(temp)
	
func Fire() -> void:
	primary_orb.SetNumber(secondary_orb.GetNumber())
	secondary_orb.SetNumber(GenerateAmmoNumber())
	#TODO: create a projectile orb

func OrientCannon() -> void:
	var mouse_pos = get_global_mouse_position()
	sprite.look_at(mouse_pos)
	var angle = global_position.angle_to_point(mouse_pos)
	secondary_orb.position = Vector2((-80)*cos(angle), (-80)*sin(angle))
	

# Start with pause menu hidden
func _ready() -> void:
	pause_menu.hide()
	primary_orb.SetNumber(GenerateAmmoNumber())
	secondary_orb.SetNumber(GenerateAmmoNumber())

func _input(event):
	if event.is_action_pressed("swap"):
		SwapAmmo()
	if event.is_action_pressed("fire"):
		Fire()

# If we need to use delta, take out the underscore to signify
func _physics_process(_delta) -> void:
	OrientCannon()

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
