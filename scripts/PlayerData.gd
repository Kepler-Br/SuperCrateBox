extends Node2D

signal score_changed

export var score: = 0 setget set_score

func set_score(value) -> void:
	score = value
	emit_signal("score_changed")
