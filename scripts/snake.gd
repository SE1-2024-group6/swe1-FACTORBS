extends Path2D

var SnakeOrb = load("res://scenes/snake_orb.tscn")
var GameMaster
var Body = []
# @export var BaseSpeed : float # Modify through inspector # does not work, inspector rounds to 0 below 0.001
var BaseSpeed = 0.0003
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
	

func GetLength():
	return len(Body)

func GetOrb(pos):
	return Body[pos].GetNumber()

# Currently set to 500% BaseSpeed at start of track and 100% at end with exponential scaling
# Takes almost exactly 30 seconds to reach the end
# I think this feels pretty good but I expect it to change when we add orb insertion
# Mess around with this and find values you think are fun
func UpdatePosition() -> void: 
	var ProgressModifier = Body[len(Body)-1].progress_ratio
	ProgressModifier = 2*(1-ProgressModifier)
	ProgressModifier = ProgressModifier * ProgressModifier 
	for orb in Body:
		orb.UpdateProgress(BaseSpeed*(1+ProgressModifier))

func SuccessfulCollision(Snorb):
	var Position = -1
	for i in range(0, len(Body)):
		if Body[i] == Snorb:
			Position = i
	if Position == -1:
		print(str(Snorb.GetNumber()))
	if Snorb.GetNumber() == 1:
		GameMaster.UpdateScore()
		DeleteSnorb(Position)
	else:
		InsertSnorb(Position)

func DeleteSnorb(Position):
	var Snorb = Body[Position]
	Body.remove_at(Position)
	Snorb.queue_free()
	if len(Body) == 0:
		GameMaster.DeleteSnake(self)

func InsertSnorb(Position):
	pass #TODO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	UpdatePosition()
	pass
