extends Node2D

export (PackedScene) var big_monster_scene
export (PackedScene) var small_monster_scene

func _ready():
	randomize()

func pick_monster():
	var monster_number = randf()
	if monster_number < 0.7:
		return small_monster_scene.instance()
	elif monster_number < 1.0:
		return big_monster_scene.instance()

func _on_Timer_timeout():
	var monster = pick_monster()
	monster.position = Vector2(0.0, 0.0)
	add_child(monster)
