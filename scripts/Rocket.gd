extends Area2D

export var speed: = Vector2(300.0, 0.0)
export var despawn_time: = 2.5 setget set_despawn_time
export(float) var damage: = 50.0
export(PackedScene) var exposion_scene

onready var root_node: Node2D = get_node("/root/Node2D")
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
	var new_explosion = exposion_scene.instance()
	root_node.add_child(new_explosion)
	new_explosion.position = position
	queue_free()
