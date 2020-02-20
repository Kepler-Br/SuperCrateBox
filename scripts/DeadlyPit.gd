extends Area2D

func _ready():
	pass


func _on_DeadlyPit_body_entered(body):
	if body.has_method("die"):
		body.die()
	if body.has_method("make_angry"):
		body.make_angry()
