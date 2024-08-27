extends Area2D

func _on_body_entered(player: Player) -> void:
	if !player: return
	HUD.update_key_label(1)
	HUD.update_message("Found a key!")
	queue_free()
