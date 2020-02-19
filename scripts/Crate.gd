extends Area2D


signal picked_up

func _on_Crate_body_entered(body):
	emit_signal("picked_up")
