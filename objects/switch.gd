extends Area2D

const KEY = preload("res://objects/key.tscn")
var can_activate: bool = false 

func _on_body_entered(player: Player) -> void:
	if !player: return
	HUD.update_message("Activate Switch: Press Enter/Confirm")
	can_activate = true

func _on_body_exited(body: Node2D) -> void:
	can_activate = false

func _input(event: InputEvent) -> void:
	if can_activate == false: return
	if Input.is_action_just_pressed("confirm"):
		HUD.update_message("Switch Activated!")
		var new_key = KEY.instantiate()
		owner.add_child(new_key)
		new_key.global_position = Vector2(global_position.x, 0)
		var new_position = global_position + Vector2(120, 60)
		var tween = create_tween()
		tween.tween_property(new_key, "position", new_position, 1.0)
		can_activate = false
		await tween.finished
		process_mode = Node.PROCESS_MODE_DISABLED
		#queue_free()
