extends Node2D

@onready var label = $NumberLabel
var number: int = 0:
	set(new_number):
		number = new_number
		label.text = str(number)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
