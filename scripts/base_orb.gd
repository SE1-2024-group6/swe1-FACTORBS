extends Node2D

@onready var label = $NumberLabel
var number = 0

func GetNumber() -> int:
	return number

func SetNumber(num) -> void:
	number = num
	label.text = str(number)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetNumber(number)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
