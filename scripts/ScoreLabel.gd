extends Label

onready var player_data: = get_node("/root/Node2D/PlayerData/")

func _ready():
	text = str(player_data.score)
	player_data.connect("score_changed", self, "_on_PlayerData_score_changed")

func _on_PlayerData_score_changed() -> void:
	text = str(player_data.score)
