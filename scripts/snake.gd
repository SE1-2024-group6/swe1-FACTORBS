extends Path2D

@onready var GameMaster = get_parent()
@onready var clearingOrbs = $"../../AudioManager/clearingOrbs"
@onready var successfulFactoring = $"../../AudioManager/successfulFactoring"
@onready var wrongBuzz = $"../../AudioManager/wrongBuzz"

var body:
	get: return get_children()
var length:
	get: return get_child_count()
var base_speed = 0.00009
var orb_spacing = 0.0165

func Generate(numbers, path=curve) -> void:
	curve = path
	for i in numbers:
		AddOrb(i, 0)
	for j in range(length):
		body[j].buffered_progress = 0 - orb_spacing*(length-j-1)

func AddOrb(number, index) -> void:
	var NewOrb = load("res://scenes/SnakeOrb.tscn").instantiate()
	add_child(NewOrb)
	move_child(NewOrb, index)
	NewOrb.number = number

# Currently set to 500% base_speed at start of track and 100% at end with exponential scaling
# Update: base_speed now increases up to double its original value as difficulty_ratio increases
# I think this feels pretty good but I expect it to change when we add orb insertion
# Mess around with this and find values you think are fun
func UpdatePosition() -> void: 
	var progress_modifier = body[length-1].progress_ratio
	progress_modifier = 3.5*(1-progress_modifier)
	progress_modifier = progress_modifier * progress_modifier 
	for orb in body:
		orb.UpdateProgress((base_speed+base_speed*GameMaster.difficulty_ratio*0.5)*(1+progress_modifier))

func Collision(divisor, index):
	var value = body[index].number	# value = number of orb at index
	if value % divisor == 0:	# if the divisor is a factor of the orb hit
		# recursively factor all contigouos orbs of the same value
		var iter = index
		while iter+1 < length and body[iter+1].number == value:
			iter += 1
		FactorSnorb(divisor, iter)
		if value/divisor != 1:
			successfulFactoring.play()
			call_deferred("InsertSnorb", int(value)/int(divisor), index)
		else:
			clearingOrbs.play()
	else:	# if the divisor isn't a factor of the orb hit
		wrongBuzz.play()
		call_deferred("InsertSnorb", divisor, index)	# insert it into the snake

func FactorSnorb(divisor, index):
	var value = body[index].number
	body[index].number = value/divisor
	if value/divisor == 1:
		#GameMaster.UpdateScore(value)
		GameMaster.UpdateScore()
		call_deferred("DeleteSnorb", index)
	if index > 0 and body[index-1].number == value:
		FactorSnorb(divisor, index-1)
	
func DeleteSnorb(index):
	var Snorb = body[index]
	Snorb.queue_free()
	await Snorb.tree_exited
	if length == 0:
		GameMaster.call_deferred("DeleteSnake", self)
	for i in range(index, length):
		body[i].UpdateProgress(-orb_spacing)

func InsertSnorb(number, index):
	index += 1
	AddOrb(number, index)
	if index < length - 1:
		body[index].UpdateProgress(body[index+1].progress_ratio)
		for i in range(index+1, length):
			body[i].UpdateProgress(orb_spacing)
	else:
		body[index].UpdateProgress(body[index-1].progress_ratio + orb_spacing)

# Merge another snake into this one
func Merge(OtherSnake):
	if self == OtherSnake:
		return
	# Insert all orbs from OtherSnake into this Snake.
	for i in range(OtherSnake.length - 1, -1, -1):
		call_deferred("InsertSnorb", OtherSnake.body[i].number, length-1)
	# Remove old snake
	GameMaster.call_deferred("DeleteSnake", OtherSnake)

func GameOver():
	GameMaster.GameOver()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster = get_parent()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if length != 0:
		UpdatePosition()
