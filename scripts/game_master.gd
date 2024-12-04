extends Node2D

var Path: Curve2D = preload("res://resources/Path1.tres")
@onready var score_label = $"Score"
@onready var SnakeTimer = $"SnakeTimer"

var current_score = 0
# var previous_score = -1
var terrarium = []
var num_snakes: int:
	get: return len(terrarium)
var ValidNumbers = []
var Random = RandomNumberGenerator.new()
var TimerLength = 22

func SpawnSnake() -> void:
	if (!SnakeTimer.is_stopped()):
		SnakeTimer.stop()
	SnakeTimer.start(TimerLength)
	var NewSnake = load("res://scenes/Snake.tscn").instantiate()
	add_child(NewSnake)
	terrarium.append(NewSnake)
	NewSnake.Generate(GenerateNumbers(), Path)
	# NewSnake.Generate([4,4,8,4,4])
	

func GenerateNumbers(amount=5):
	var SnakeNumbers = []
	for i in range(amount): # make variable when difficulty is implemented
		SnakeNumbers.append(ValidNumbers[Random.randi_range(0, 25)]) #also make difficulty variable
	return SnakeNumbers

func GetRandomSnormber():
	var SnakeSelect
	if num_snakes == 1:
		SnakeSelect = terrarium[0]
	elif num_snakes > 1:
		SnakeSelect = terrarium[Random.randi_range(1, num_snakes)-1]
	else:
		return 2
	return SnakeSelect.body[(Random.randi_range(1, SnakeSelect.length)-1)].number

func DeleteSnake(DeadSnake):
	for i in range(num_snakes):
		if terrarium[i] == DeadSnake:
			terrarium.remove_at(i)
			DeadSnake.queue_free()
			await DeadSnake.tree_exited
			if len(terrarium) == 0:
				call_deferred("SpawnSnake") # Don't ask
			return
		else:
			print("Failed to kill snake")

func _ready() -> void:
	Random.randomize()
	score_label.text = " SCORE: 0" 
	var Primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
	for i in range(2,100):
		if not i in Primes:
			ValidNumbers.append(i) # This is an awful idea, if anyone has a better one please implement it
	SpawnSnake()

#func _process(_delta: float) -> void:
#	update_score()

# function to update score only when it changes (instead of every frame)
# 
#		Nate here, this is kind of pointless so I replaced it
#
#func update_score() -> void:
#	if current_score != previous_score:
#		score_label.text = " SCORE: " + str(current_score)
#		previous_score = current_score

func UpdateScore(amount=1):
	current_score += amount
	score_label.text = " SCORE: " + str(current_score)

func _on_snake_timer_timeout() -> void:
	call_deferred("SpawnSnake")
