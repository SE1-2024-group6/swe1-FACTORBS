extends PathFollow2D

@onready var Snake = get_parent()
@onready var BaseOrb = $BaseOrb
@onready var number: int:
	get: return BaseOrb.number
	set(new_number): BaseOrb.number = new_number
var buffered_progress = 0	# used to buffer progress_ratio when negative
var index:
	get: return get_index()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func UpdateProgress(change) -> void:
	buffered_progress += change
	progress_ratio = max(0, buffered_progress)
	if progress_ratio == 1:
		Snake.GameOver()

func Collide(number) -> void:
	Snake.Collision(number, index)
