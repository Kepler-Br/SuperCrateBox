extends Node2D

onready var timer: = get_node("Timer")
export var gravity: = 1200.0
export var velocity: = Vector2(0.0, -400.0)

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	queue_free()

func _physics_process(delta):
	velocity.y = min(velocity.y + gravity*delta, 700.0)
	self.position += velocity*delta
	
