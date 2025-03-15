extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if Global.health < Global.max_health:
			Sfx.get_child(1).play()
			Global.health += 1
			queue_free()
