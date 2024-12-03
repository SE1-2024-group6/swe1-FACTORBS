extends PathFollow2D

@onready var BaseOrb = $BaseOrb
var prog = 0 # Allows us to start below zero and collapse the snake
var Snake

func SetNumber(num) -> void:
	BaseOrb.SetNumber(num)

func GetNumber() -> int:
	return BaseOrb.GetNumber()

func UpdateProgress(change) -> void:
	prog += change
	if (prog > 0):
		progress_ratio = prog
	else:
		progress_ratio = 0

func Collide(number) -> void:
	if GetNumber() % number == 0:
		# SetNumber(Value / number)
		Snake.SuccessfulCollision(self, number)
	else:
		Snake.FailedCollision(self, number)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Snake = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
