extends Node2D

var Path: Curve2D = preload("res://resources/Path1.tres")
@onready var score_label = $"Score"
@onready var SnakeTimer = $"SnakeTimer"
@onready var Game_over_menu = $"../CanvasLayer2/GameOverMenu"
@onready var go_score = $"../CanvasLayer2/GameOverMenu/ColorRect/sLabel"
@onready var go_hiscore = $"../CanvasLayer2/GameOverMenu/ColorRect/hsLabel"

var current_score = 0
var high_score = 0
# var previous_score = -1
var difficulty_ratio = 0
var terrarium = []
var num_snakes: int:
	get: return len(terrarium)
var ValidNumbers = []
var Random = RandomNumberGenerator.new()
var TimerLength = 21

func SpawnSnake() -> void:
	if (!SnakeTimer.is_stopped()):
		SnakeTimer.stop()
	SnakeTimer.start(TimerLength+10*difficulty_ratio)
	var NewSnake = load("res://scenes/Snake.tscn").instantiate()
	add_child(NewSnake)
	terrarium.append(NewSnake)
	NewSnake.Generate(GenerateNumbers(), Path)
	# NewSnake.Generate([4,4,8,4,4])
	

func GenerateNumbers():
	var SnakeNumbers = []
	var SnakeLength = 4
	if current_score > 60:
		SnakeLength = 6
	elif current_score > 20:
		SnakeLength = 5
	#for i in range(4+int(2*difficulty_ratio)):
	for i in range(SnakeLength):
		SnakeNumbers.append(ValidNumbers[Random.randi_range(0, 20+(40*difficulty_ratio))])
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

func GameOver():
	get_tree().paused = true
	
#Score Labels
	if current_score > high_score:
		go_hiscore.text = "NEW RECORD! YOUR NEW HIGH SCORE IS: " + str(current_score)
		go_score.text = "WOW! You beat your old record of " + str(high_score) + "! Outstanding Job!"
		high_score = current_score
		save_high_score()
	else:
		go_hiscore.text = "Your All-Time High Score is: " + str(high_score)
		
		#values for the score statements can be changed
		if current_score == 0:
			go_score.text = "Better Luck Next Time! Your Score Was: "
		elif current_score < 50:
			go_score.text = "Good Work! Your Score Was: "
		elif current_score < 100:
			go_score.text = "Awesome Job! Your Score Was: "
		else:
			go_score.text = "Amazing Stuff! Your Score Was: "
		
		# Append score
		go_score.text += str(current_score)
	
	Game_over_menu.show()
	

func _ready() -> void:
	load_high_score()
	Game_over_menu.hide()
	Random.randomize()
	score_label.text = " SCORE: 0" 
	var Primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
	for i in range(2,100):
		if not i in Primes:
			ValidNumbers.append(i) # This is an awful idea, if anyone has a better one please implement it
	SpawnSnake()

func UpdateScore(amount=1):
	current_score += amount
	score_label.text = " SCORE: " + str(current_score)
	if current_score < 150:
		difficulty_ratio = current_score/150.0
	else:
		difficulty_ratio = 1

func _on_snake_timer_timeout() -> void:
	call_deferred("SpawnSnake")

# Save/Load Functionality
func save_high_score():
	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	var save_data: Dictionary = {"high_score": high_score}
	var jstr = JSON.stringify(save_data)
	file.store_line(jstr)
	
func load_high_score():
	if FileAccess.file_exists("user://save_game.json"):
		var file = FileAccess.open("user://save_game.json", FileAccess.READ)
		if FileAccess.file_exists("user://save_game.json") == true:
			if not file.eof_reached():
				var current_line = JSON.parse_string(file.get_line())
				if current_line:
					high_score = current_line["high_score"]
