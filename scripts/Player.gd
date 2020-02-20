extends KinematicBody2D

export var gravity: = 1800.0
export var speed: = Vector2(300.0, 650.0)
export(PackedScene) var dead_player
export(Array, NodePath) var weapon_paths: Array
export(int) var current_weapon_index

onready var animated_sprite: = get_node("./AnimatedSprite")
onready var root_node: Node2D = get_node("/root/Node2D/")
onready var player_data: Node2D = get_node("/root/Node2D/PlayerData/")

var velocity: = Vector2.ZERO
var weapon_node: Node2D

const floor_normal: = Vector2.UP

func _ready():
	weapon_node = get_node(weapon_paths[current_weapon_index])
	player_data.connect("score_changed", self, "_on_crate_pickup")

func _on_crate_pickup():
	var new_weapon_index = randi()%len(weapon_paths)
	while new_weapon_index == current_weapon_index:
		new_weapon_index = randi()%len(weapon_paths)
	current_weapon_index = new_weapon_index
	weapon_node = get_node(weapon_paths[current_weapon_index])

func _set_animation() -> void:
	if Input.is_action_pressed("move_right") and is_on_floor():
		animated_sprite.play("walk")
	elif Input.is_action_pressed("move_left") and is_on_floor():
		animated_sprite.play("walk")
	elif not is_on_floor():
		animated_sprite.play("jump")
	else:
		animated_sprite.play("idle")
	
	if Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		animated_sprite.flip_h = true

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculace_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func _physics_process(delta: float) -> void:
	_set_animation()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	# REMOVE THIS IF NEEDED
	is_jump_interrupted = false
	velocity = calculace_velocity(velocity, get_direction(), speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, floor_normal)
	if Input.is_action_just_pressed("fire"):
		weapon_node.fire(!animated_sprite.flip_h)

func die() -> void:
	var new_dead_player = dead_player.instance()
	new_dead_player.position = position
	root_node.add_child(new_dead_player)
