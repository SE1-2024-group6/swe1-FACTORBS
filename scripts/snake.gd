extends Path2D

@onready var GameMaster = get_parent()

var body:
	get: return get_children()
var length:
	get: return get_child_count()
var base_speed = 0.00018
var orb_spacing = 0.055

func Generate(numbers) -> void:
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
# I think this feels pretty good but I expect it to change when we add orb insertion
# Mess around with this and find values you think are fun
func UpdatePosition() -> void: 
	var progress_modifier = body[length-1].progress_ratio
	progress_modifier = 2.5*(1-progress_modifier)
	progress_modifier = progress_modifier * progress_modifier 
	for orb in body:
		orb.UpdateProgress(base_speed*(1+progress_modifier))

func Collision(divisor, index):
	var value = body[index].number	# value = number of orb at index
	if value % divisor == 0:	# if the divisor is a factor of the orb hit
		# recursively factor all contigouos orbs of the same value
		var iter = index
		while iter+1 < length and body[iter+1].number == value:
			iter += 1
		FactorSnorb(divisor, iter)
		if value/divisor != 1:
			call_deferred("InsertSnorb", int(value)/int(divisor), index)
	else:	# if the divisor isn't a factor of the orb hit
		call_deferred("InsertSnorb", divisor, index)	# insert it into the snake

func FactorSnorb(divisor, index):
	var value = body[index].number
	body[index].number = value/divisor
	if value/divisor == 1:
		GameMaster.UpdateScore(value)
		call_deferred("DeleteSnorb", index)
	if index > 0 and body[index-1].number == value:
		FactorSnorb(divisor, index-1)
	
func DeleteSnorb(index):
	var Snorb = body[index]
	Snorb.queue_free()
	await Snorb.tree_exited
	if length == 1:
		GameMaster.DeleteSnake(self)
	for i in range(index, length):
		body[i].UpdateProgress(-orb_spacing)

func InsertSnorb(number, index):
	AddOrb(number, index)
	if index < length-1:
		body[index].UpdateProgress(body[index+1].progress_ratio)
		for i in range(index+1, length):
			body[i].UpdateProgress(orb_spacing)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if length != 0:
		UpdatePosition()
