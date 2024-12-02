extends Node2D

@onready var score_label = $"Score"
@onready var SnakeTimer = $"SnakeTimer"

var current_score = 0
# var previous_score = -1
var Snake = load("res://scenes/snake.tscn")
var Terrarium = []
var ValidNumbers = []
var Random = RandomNumberGenerator.new()
var TimerLength = 33

func SpawnSnake() -> void:
	if (!SnakeTimer.is_stopped()):
		SnakeTimer.stop()
	SnakeTimer.start(TimerLength)
	var NewSnake = Snake.instantiate()
	add_child(NewSnake)
	Terrarium.append(NewSnake)
	NewSnake.Generate(GenerateNumbers())
	# NewSnake.Generate([4,4,4,4,4])
	

func GenerateNumbers():
	var SnakeNumbers = []
	for i in range(5): # make variable when difficulty is implemented
		SnakeNumbers.append(ValidNumbers[Random.randi_range(0, 25)]) #also make difficulty variable
	return SnakeNumbers

func GetRandomSnorb():
	var NumSnakes = len(Terrarium)
	var SnakeSelect
	if NumSnakes == 1:
		SnakeSelect = Terrarium[0]
	elif NumSnakes > 1:
		SnakeSelect = Terrarium[Random.randi_range(1, NumSnakes)-1]
	else:
		return -1
	return SnakeSelect.GetOrb(Random.randi_range(1, SnakeSelect.GetLength())-1)

func DeleteSnake(DeadSnake):
	for i in range(0, len(Terrarium)):
		if Terrarium[i] == DeadSnake:
			Terrarium.remove_at(i)
			DeadSnake.queue_free()
			if len(Terrarium) == 0:
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

func UpdateScore():
	current_score += 1
	score_label.text = " SCORE: " + str(current_score)

func _on_snake_timer_timeout() -> void:
	call_deferred("SpawnSnake")
