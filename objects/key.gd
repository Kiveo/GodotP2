extends Area2D

@onready var key_animation: AnimationPlayer = %KeyAnimation

func _ready() -> void:
	key_animation.play("float")

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Body detected: ", body)
	if (body is Player):
		pickup()
		return
	if body.is_in_group("friendly") and Input.is_action_pressed("hold_player"):
		pickup()

func pickup() -> void:
	HUD.update_key_label(1)
	HUD.update_message("Found a key!")
	queue_free()
