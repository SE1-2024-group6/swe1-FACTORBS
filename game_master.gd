extends Node2D

@onready var score_label = $"Score"

var current_score = 0
var previous_score = -1



func _process(delta: float) -> void:
	update_score()

# function to update score only when it changes (instead of every frame)
func update_score() -> void:
	if current_score != previous_score:
		score_label.text = " SCORE: " + str(current_score)
		previous_score = current_score
