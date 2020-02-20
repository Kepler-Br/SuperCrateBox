extends KinematicBody2D

enum MOVEMENT_SIDE{
	right,
	left
}

export(float) var health = 100.0

var animated_sprite
var movement = Vector2(0.0, 0.0)
var movement_side
var movement_speed

const GRAVITY = 20.0
const MAX_ACCELERATION = 550.0
const SIDE_MOVEMENT_SPEED = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	movement_side = MOVEMENT_SIDE.right if randi()%2 == 0 else MOVEMENT_SIDE.left
	animated_sprite = get_node("./AnimatedSprite")
	if movement_side == MOVEMENT_SIDE.right:
		animated_sprite.flip_h = false
		movement_speed = SIDE_MOVEMENT_SPEED
	else:
		movement_speed = -SIDE_MOVEMENT_SPEED
		animated_sprite.flip_h = true
	
func change_movement_side():
	animated_sprite.flip_h = !animated_sprite.flip_h
	movement_speed = movement_speed * -1

func _physics_process(delta):
	movement.y = min(movement.y + GRAVITY, MAX_ACCELERATION)
	if is_on_wall():
		change_movement_side()
	movement.x = movement_speed
	movement = self.move_and_slide(movement, Vector2(0.0, -1.0))
#	var collision: = move_and_collide(movement * delta)
#	if collision:
#		movement = movement.slide(collision.normal)
#		if collision.get_collider().has_method("die"):
#			collision.get_collider().die()
	
func damage(points: float):
	health -= points
	if health < 0.0:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("die"):
		body.die()
