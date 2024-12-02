extends PathFollow2D

@onready var Snake = get_parent()
var index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#func UpdateProgress(change) -> void:
	#prog += change
	#if (prog > 0):
		#progress_ratio = prog
	#else:
		#progress_ratio = 0
#
func Collide(number) -> void:
	Snake.Collision(index, number)
	#if self.number % number == 0:
		#if index > 0 and Snake.body[index-1] == self.number:
			#Snake.body[index-1].Collide(number)
		#if index < Snake.length and Snake.body[index+1] == self.number:
			#Snake.body[index+1].Collide(number)
		#
		#self.number = self.number / number
	#else:
		#Snake.add
