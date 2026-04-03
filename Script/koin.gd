extends Area3D

func _process(delta):
	rotate_y(2.0 * delta) 

func _on_body_entered(body):
	if body.name == "Player":
		body.add_coin()
		queue_free()
