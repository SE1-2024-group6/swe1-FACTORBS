extends Path2D

var SnakeOrb = load("res://scenes/snake_orb.tscn")
var GameMaster
var Body = []
# @export var BaseSpeed : float # Modify through inspector # does not work, inspector rounds to 0 below 0.001
var BaseSpeed = 0.00012
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
# I think this feels pretty good but I expect it to change when we add orb insertion
# Mess around with this and find values you think are fun
func UpdatePosition() -> void: 
	var ProgressModifier = Body[len(Body)-1].progress_ratio
	ProgressModifier = 2.5*(1-ProgressModifier)
	ProgressModifier = ProgressModifier * ProgressModifier 
	for orb in Body:
		orb.UpdateProgress(BaseSpeed*(1+ProgressModifier))

func SuccessfulCollision(Snorb, Divisor):
	var Position = -1
	var Value = Snorb.GetNumber()
	for i in range(0, len(Body)):
		if Body[i] == Snorb:
			Position = i
	if Position == -1:
		print(str(Value))
	var iter = Position
	while iter+1 < len(Body) and Body[iter+1].GetNumber() == Value:
		iter += 1
	FactorSnorb(iter, Divisor)
	if Value/Divisor != 1:
		call_deferred("InsertSnorb", int(Value)/int(Divisor), Position)
	

func FailedCollision(Snorb, Divisor):
	var Position = -1
	for i in range(0, len(Body)):
		if Body[i] == Snorb:
			Position = i
	call_deferred("InsertSnorb", Divisor, Position)
	# InsertSnorb(Divisor, Position)

func FactorSnorb(Position, Divisor):
	var Value = Body[Position].GetNumber()
	Body[Position].SetNumber(Value/Divisor)
	if Value/Divisor == 1:
		GameMaster.UpdateScore()
		call_deferred("DeleteSnorb", Position)
		#DeleteSnorb(Position, Value)
	if Position > 0 and Body[Position-1].GetNumber() == Value:
		FactorSnorb(Position-1, Divisor)
	#if Position+1 < len(Body) and Body[Position+1].GetNumber() == Value:
	#	FactorSnorb(Position+1, Divisor)
	

func DeleteSnorb(Position):
	var Snorb = Body[Position]
	Body.remove_at(Position)
	Snorb.queue_free()
	if len(Body) == 0:
		GameMaster.DeleteSnake(self)
		return
	for i in range(Position, len(Body)):
		Body[i].UpdateProgress(-OrbSpacing)
#	var iter = Position
#	if Position > 0 and Body[Position-1].GetNumber() == 1:
#		GameMaster.UpdateScore()
#		call_deferred("DeleteSnorb", Position-1)
#		#DeleteSnorb(Position-1)
#	if Position < len(Body) and Body[Position].GetNumber() == 1:
#		GameMaster.UpdateScore()
#		call_deferred("DeleteSnorb", Position)
		#DeleteSnorb(Position)

func InsertSnorb(Number, Position):
	AddOrb(Number, Position)
	if Position == len(Body)-1:
		return
	Body[Position].UpdateProgress(Body[Position+1].progress_ratio)
	for i in range(Position+1, len(Body)):
		Body[i].UpdateProgress(OrbSpacing)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	UpdatePosition()
	pass
