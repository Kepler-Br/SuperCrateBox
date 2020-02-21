extends Node2D

export (PackedScene) var big_monster_scene
export (PackedScene) var small_monster_scene
export (PackedScene) var big_monster_angry_scene
export (PackedScene) var small_monster_angry_scene

onready var root_node: = get_node("/root/Node2D")

func _ready():
	randomize()

func spawn_angry(is_big: bool):
	var monster
	if is_big:
		monster = big_monster_angry_scene.instance()
	else:
		monster = small_monster_angry_scene.instance()
	root_node.add_child(monster)
	monster.position = position

func pick_monster():
	var monster_number = randf()
	if monster_number < 0.7:
		return small_monster_scene.instance()
	elif monster_number < 1.0:
		return big_monster_scene.instance()

func _on_Timer_timeout():
	var monster = pick_monster()
	monster.position = position
	root_node.add_child(monster)
