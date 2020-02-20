extends Area2D

func _ready():
	pass


func _on_DeadlyPit_body_entered(body):
	if body.has_method("die"):
		body.die()
	if body.get_collision_layer()
