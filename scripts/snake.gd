extends Path2D

var SnakeOrb = load("res://scenes/snake_orb.tscn")
var Body = []
# @export var BaseSpeed : float # Modify through inspector
var BaseSpeed = 0.0004
var OrbSpacing = 0.055

func Generate(numbers) -> void:
	for i in numbers:
		AddOrb(i, 0)
	var NumOrbs = len(Body)
	for j in range(NumOrbs):
		Body[j].prog = 0 - OrbSpacing*(NumOrbs-j-1)

func AddOrb(num, pos) -> void:
	var NewOrb = SnakeOrb.instantiate()
	add_child(NewOrb)
	NewOrb.SetNumber(num)
	if (pos == -1):
		Body.append(NewOrb)
	else:
		Body.insert(pos, NewOrb)

func UpdatePosition() -> void:
	for orb in Body:
		orb.UpdateProgress(BaseSpeed)
		#orb.progress_ratio += BaseSpeed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	UpdatePosition()
	pass
