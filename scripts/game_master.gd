extends Node2D

@onready var score_label = $"Score"

var current_score = 0
var previous_score = -1
var Snake = load("res://scenes/snake.tscn")

func SpawnSnake() -> void:
	var NewSnake = Snake.instantiate()
	add_child(NewSnake)
	NewSnake.Generate(GenerateNumbers())

func GenerateNumbers():
	return [1,2,3,4]

func _ready() -> void:
	SpawnSnake()

func _process(_delta: float) -> void:
	update_score()

# function to update score only when it changes (instead of every frame)
func update_score() -> void:
	if current_score != previous_score:
		score_label.text = " SCORE: " + str(current_score)
		previous_score = current_score
