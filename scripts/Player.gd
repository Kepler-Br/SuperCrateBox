extends KinematicBody2D

onready var animated_sprite: = get_node("./AnimatedSprite")

export var gravity: = 1800.0
export var speed: = Vector2(300.0, 650.0)
export(PackedScene) var dead_player

var velocity: = Vector2.ZERO

const floor_normal: = Vector2.UP

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
	velocity = calculace_velocity(velocity, get_direction(), speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, floor_normal)
	if Input.is_action_just_pressed("fire"):
		var dead_player_node = dead_player.instance()
		dead_player_node.position = position
		get_node("/root/Node2D/").add_child(dead_player_node)

