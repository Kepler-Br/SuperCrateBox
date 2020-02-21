extends KinematicBody2D

onready var sprite: Sprite = get_node("Sprite")
onready var kinematic_collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var area_collision_shape: CollisionShape2D = get_node("Area2D/CollisionShape2D")
onready var timer: Timer = get_node("Timer")

export(float) var max_speed: float = 600.0
export(Vector2) var speed: Vector2 = Vector2(400.0, 0.0)
export(float) var damage: float = 100.0
export(float) var despawn_time: = 1.0
#var velocity = Vector2(speed.x, 0.0)

func _ready():
	if despawn_time > 0.0:
		timer.wait_time = despawn_time
		timer.start()

func _new_velocity(collision_normal: Vector2) -> Vector2:
	var direction = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized()
	var rotation = atan2(direction.y, direction.x)*180.0/PI
	sprite.rotation_degrees = rotation
	kinematic_collision_shape.rotation_degrees = rotation
	area_collision_shape.rotation_degrees = rotation
	return Vector2(max_speed, max_speed) * direction

func _physics_process(delta):
	var collision = move_and_collide(speed*delta)
	if collision:
		speed = _new_velocity(collision.normal)


func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)

func _on_Timer_timeout():
	queue_free()
