extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Sfx.get_child(0).play()
		Global.coins += 1
		queue_free()
