extends Area2D

func _ready():
	pass


func _on_Timer_timeout():
	queue_free()


func _on_RocketExplosion_body_entered(body):
	if body.has_method("damage"):
		body.damage(400)
