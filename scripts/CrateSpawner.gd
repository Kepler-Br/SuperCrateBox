tool
class_name CrateSpawner
extends Node2D

export var spawn_width: = 0.0


#func _process(delta):
#	update()

func _draw():
	if Engine.is_editor_hint():
		draw_line(Vector2(-spawn_width/2.0, 0.0), Vector2(spawn_width/2.0, 0.0), Color(1.0, 1.0, 1.0, 1.0), 5.0)
