extends Node2D

export(PackedScene) var bullet: PackedScene
export(NodePath) var player_path: NodePath
export(NodePath) var left_firehole_path: NodePath
export(NodePath) var right_firehole_path: NodePath
export(float) var reload_time: = 1.0
export(int) var bullet_count: = 7
export(float) var life_time: = 0.4

onready var player: KinematicBody2D = get_node(player_path)
onready var left_firehole: Node2D = get_node(left_firehole_path)
onready var right_firehole: Node2D = get_node(right_firehole_path)
onready var root_node: Node2D = get_node("/root/Node2D/")
onready var timer: Timer = Timer.new()

func _ready():
	timer.one_shot = true
	timer.wait_time = reload_time
	add_child(timer)

func _random_spread(degrees: float, power: float, speed: float) -> Vector2:
	var angle = rand_range(-degrees/2.0, degrees/2.0)
	var current_speed = rand_range(-speed/2.0, speed/2.0)
	return Vector2(current_speed, power*angle)

func _spawn_bullet(direction_right: bool):
	var new_bullet: Node2D = bullet.instance()
	root_node.add_child(new_bullet)
	var firehole: Node2D = right_firehole if direction_right else left_firehole
	new_bullet.position = firehole.position + player.position;
	new_bullet.despawn_time = life_time
	if direction_right:
		new_bullet.speed = Vector2(500.0, 0.0) + _random_spread(1.0, 100.0, 100.0)
	else:
		new_bullet.speed = Vector2(-500.0, 0.0) - _random_spread(1.0, 100.0, 100.0)

func fire(direction_right: bool):
	if not timer.is_stopped():
		return
	var i = 0;
	while (i < bullet_count):
		_spawn_bullet(direction_right)
		i += 1
	timer.start()
