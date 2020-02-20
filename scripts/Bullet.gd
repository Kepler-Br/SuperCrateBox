extends Area2D

export var speed: float = 500.0

func _ready():
	pass

func _physics_process(delta):
	position.x += speed*delta


func _on_Bullet_body_entered(body):
	
	queue_free()
