extends PathFollow2D

@onready var Snake = get_parent()
@onready var BaseOrb = $BaseOrb
var buffered_progress	# used to buffer progress_ratio when negative
var number:
	get: return BaseOrb.number
	set(number): BaseOrb.number = number
var index:
	get:
		for i in Snake.length:
			if Snake.get_child(i) == self:
				return i
		return -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func UpdateProgress(change) -> void:
	buffered_progress += change
	progress_ratio = min(0, buffered_progress)
#
func Collide(number) -> void:
	Snake.Collision(index, number)
