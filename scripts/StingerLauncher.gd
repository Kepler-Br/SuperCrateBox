extends Node2D

export(PackedScene) var bullet: PackedScene
export(NodePath) var player_path: NodePath
export(NodePath) var left_firehole_path: NodePath
export(NodePath) var right_firehole_path: NodePath
export(float) var reload_time: = 1.0
export(float) var life_time: = 0.4

onready var player: KinematicBody2D = get_node(player_path)
onready var left_firehole: Node2D = get_node(left_firehole_path)
onready var right_firehole: Node2D = get_node(right_firehole_path)
onready var root_node: Node2D = get_node("/root/Node2D/")
onready var timer: Timer = Timer.new()
onready var fire_sound: AudioStreamPlayer = get_node("FireSound")

func _ready():
	timer.one_shot = true
	timer.wait_time = reload_time
	add_child(timer)

func _spawn_bullet(direction_right: bool):
	var new_bullet: Node2D = bullet.instance()
	root_node.add_child(new_bullet)
	var firehole: Node2D = right_firehole if direction_right else left_firehole
	new_bullet.position = firehole.position + player.position;
	new_bullet.despawn_time = life_time
	if direction_right:
		new_bullet.speed = Vector2(600.0, 0.0)
	else:
		new_bullet.speed = Vector2(-600.0, 0.0)

func fire(direction_right: bool):
	if not timer.is_stopped():
		return
	fire_sound.play()
	_spawn_bullet(direction_right)
	timer.start()
