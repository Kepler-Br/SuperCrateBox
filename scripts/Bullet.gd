extends Area2D

export var speed: = Vector2(500.0, 0.0)
export var despawn_time: = 1.0 setget set_despawn_time
export(float) var damage: = 50.0

onready var timer: Timer = get_node("Timer")

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	if despawn_time > 0.0:
		timer.wait_time = despawn_time
		timer.start()
		
func set_despawn_time(value):
	despawn_time = value
	if despawn_time > 0.0:
		timer.wait_time = despawn_time
		timer.start()

func _on_timer_timeout():
	queue_free()

func _physics_process(delta):
		position += speed*delta

func _on_Bullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	queue_free()
